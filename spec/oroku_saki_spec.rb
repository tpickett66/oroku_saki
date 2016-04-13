require 'spec_helper'

RSpec.describe OrokuSaki do
  describe '.shred!(str)' do
    it 'must zero out the string' do
      str = 'I am a destroyer of worlds, and I fear no one!'
      length = str.length
      OrokuSaki.shred!(str)

      expect(str).to eq Array.new(length, "\u0000").join('')
    end

    it 'must raise an exception when the type is mismatched' do
      message = 'OrokuSaki.shred! received 4 (Fixnum), expected String!'
      expect { OrokuSaki.shred!(4) }.to raise_error(TypeError, message)
    end
  end

  # There isn't really a good way to test finalizers since there isn't any way
  # to force the GC to reap a particular object. The following tests are just
  # verifying other behavior of the method.
  describe '.shred_later(str)' do
    it 'must return the original string' do
      return_value = OrokuSaki.shred_later('foobar')
      expect(return_value).to eq 'foobar'
    end

    it 'must raise an exception when a non-string object is passed' do
      expect { OrokuSaki.shred_later(42) }.
        to raise_error(TypeError, /received 42 \(Fixnum\)/)
    end
  end
end
