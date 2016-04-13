module OrokuSaki
  # A handful of extensions included in String to give easy access to the shred
  # methods.
  module StringExt
    # Zero out the receiver
    #
    # Delegates to the method with the same name on the {OrokuSaki} method.
    # @return [nil]
    def shred!
      OrokuSaki.shred!(self)
    end

    # Attach a zeroing finalizer to the receiver
    #
    # Delegates to the method with the same name on the {OrokuSaki} method.
    # @return [self]
    def shred_later
      OrokuSaki.shred_later(self)
    end
  end
end
String.send(:include, OrokuSaki::StringExt)
