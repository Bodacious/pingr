# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
import "./lib/tasks/pingr.rake"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

Bundler::GemHelper.install_tasks
