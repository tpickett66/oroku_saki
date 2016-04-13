module OrokuSaki
  module StringExt
    def shred!
      OrokuSaki.shred!(self)
    end

    def shred_later
      OrokuSaki.shred_later(self)
    end
  end
end
String.send(:include, OrokuSaki::StringExt)
