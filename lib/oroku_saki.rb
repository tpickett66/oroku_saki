require 'oroku_saki/version'
require 'oroku_saki/oroku_saki'
require 'oroku_saki/string_ext'

require 'objspace'

module OrokuSaki
  STRING_FINALIZER =  ->(id) {
    OrokuSaki.shred!(ObjectSpace._id2ref(id))
  }

  def self.shred_later(str)
    if !(String === str)
      raise TypeError,
        "OrokuSaki.shred_later received #{str} (#{str.class}), expected String!"
    end
    ObjectSpace.define_finalizer(str, STRING_FINALIZER)
    str
  end
end
