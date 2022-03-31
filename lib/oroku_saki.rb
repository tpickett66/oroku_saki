require 'oroku_saki/version'
require 'oroku_saki/oroku_saki'
require 'oroku_saki/string_ext'

require 'objspace'

module OrokuSaki
  STRING_FINALIZER =  ->(id) {
    OrokuSaki.shred!(ObjectSpace._id2ref(id)) rescue nil
  }
  private_constant :STRING_FINALIZER

  class << self
    private :secure_compare_c
  end

  # Attaches the shred method as a finalizer for the passed string
  #
  # Gems working with sensitive data that needs to be returned to the user need
  # a way to ensure the data gets cleared from memory without user intervention.
  # Having this finalizer attached ensures the sensitive contents will be zeroed
  # before the GC reaps the object.
  #
  # @param [String] str The string to be shredded befor GC reaping
  # @return [String] The original string
  # @raise [TypeError] When passed something other than a String
  def self.shred_later(str)
    if !(String === str)
      raise TypeError,
        "OrokuSaki.shred_later received #{str} (#{str.class}), expected String!"
    end
    ObjectSpace.define_finalizer(str, STRING_FINALIZER) unless str.frozen?
    str
  end

  # Bitewise compare two strings in constant time
  #
  # @param [String] a The first string to look at
  # @param [String] b The second string to look at
  # @return [Boolean]
  # @raise [TypeError] When passed something other than a String for either argument
  def self.secure_compare(a, b)
    secure_compare_c(a, b) == 0
  end
end
