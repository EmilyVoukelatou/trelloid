require 'spec_helper'
require 'trelloid'
include Trelloid

describe Trelloid do

  let(:blk){ Proc.new {process { 1+1 }} }
  let(:task){Task.new('A task', &blk)}
  let(:card){double("Trello::Card").stub(:name => "A task")}
  let(:api_key){"api_key"}
  let(:token){"token"}
  let(:bot){Trelloid::Bot.new(api_key, token)}

  let(:blk)do
    Proc.new {process { 1+1 }}
  end

  let(:task){Task.new('A task', &blk)}

  let(:card)do
    card = double("Trello::Card")
    card.stub(:name => "A task")
  end

  describe Bot do

    subject{bot}

    describe "#initialize" do
      its(:api_key){should eq api_key}
      its(:token){should eq token}
    end

    describe "#add_task" do
      it "Adds task" do
        bot.add_task task
        bot.tasks.length.should eq 1
      end
    end

    describe "#find_task" do
      before(:each){bot.add_task task}
      it{bot.find_task("A task").should eq task}
      it{bot.find_task("Not a task").should eq nil}
    end

    describe "DSL methods" do
      describe "#task" do

      end
    end

  end

  
  describe Task do
  
    subject{ task }
    its(:name){should eq 'A task'}
    it{subject.proc.call.should eq 2}

  end

end

