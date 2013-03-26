require 'celluloid'
require 'trello'
require 'active_support/all'

require 'trelloid/version'

module Trelloid
  class Bot

    include Celluloid

    attr_reader :api_key, :token, :tasks, :interval

    def initialize(api_key, token, options = {})
      @api_key = api_key
      @token = token
      @tasks = []
      @interval = options.delete(:interval) || 30
      @task_runners = TaskRunner.pool
      @client = Trello::Client.new(
        developer_public_key: @api_key,
        member_token: @token
      )
    end

    def run
      interrupted = false
      start_polling
      trap('INT'){interrupted = true}
      while !interrupted
        sleep 1
      end
    end

    def behaviour(&blk)
      instance_eval(&blk)
    end

    def task(name, &blk)
      add_task(Task.new(name, &blk))
    end

    def add_task(task)
      @tasks << task
    end

    def find_task(title)
     tasks.select{|t| t.match? title}.first
    end

    def start_polling
      @poller = every(interval){poll}
      @poller.fire
    end

    private

    def poll
     cards = @client.find(:members, 'me').cards
     cards.each do |card|
      task = find_task card.name
      run_task(task, card)
     end
    end

    def run_task(task, card)
      @task_runners.run(task, card)
    end

  end

  class Task

    attr_reader :name, :proc

    def initialize(name, &blk)
      @name = name
      instance_eval(&blk)
    end

    def process(&blk)
      @proc = blk
    end

    def match?(title)
      !!name.match(title)
    end

  end

  class TaskRunner

    include Celluloid
    attr_reader :card, :task

    def run(task, card)
      assign_instance_variables(task, card)
      instance_eval(&task.proc)
    end

    private

    def assign_instance_variables(task, card)
      @card = card
      @task = task
    end

  end

end
