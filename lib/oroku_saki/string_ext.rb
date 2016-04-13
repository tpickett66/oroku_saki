module OrokuSaki
  module StringExt
    def shred!
      OrokuSaki.shred!(self)
    end
  end
end
String.send(:include, OrokuSaki::StringExt)
