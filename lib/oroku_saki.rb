require 'oroku_saki/version'
require 'oroku_saki/oroku_saki'
require 'oroku_saki/string_ext'

require 'objspace'

module OrokuSaki
  STRING_FINALIZER =  ->(id) {
    OrokuSaki.shred!(ObjectSpace._id2ref(id))
  }
  private_constant :STRING_FINALIZER

  # Attaches the shred method as a finalizer for the passed string
  #
  # Gems working with sensitive data that needs to be returned to the user need
  # a way to ensure the data gets cleared from memory without user intervention.
  # Having this finalizer attached ensures the sensitive contents will be zeroed
  # before the GC reaps the object.
  #
  # @param [String] str The string to be shredded befor GC reaping
  # @return [String] The original string
  #
  def self.shred_later(str)
    if !(String === str)
      raise TypeError,
        "OrokuSaki.shred_later received #{str} (#{str.class}), expected String!"
    end
    ObjectSpace.define_finalizer(str, STRING_FINALIZER)
    str
  end
end
