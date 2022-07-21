# frozen_string_literal: true

# eager loads files in /lib/core_ext
Dir[File.join(Rails.root, 'lib', 'core_ext', '*.rb')].each { |l| require l }
