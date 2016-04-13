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

  describe '.shred_later(str)' do
    # This isn't really a good test since it doesn't verify what's being
    # returned or even if there is a finalizer actually set; but, due to the
    # non-deterministic nature of the GC we can't actually force an object to
    # be collected.
    it 'must define a finalizer on the supplied string' do
      return_value = OrokuSaki.shred_later('foobar')
      expect(return_value).to_not be_nil
    end

    it 'must raise an exception when a non-string object is passed' do
      expect { OrokuSaki.shred_later(42) }.
        to raise_error(TypeError, /received 42 \(Fixnum\)/)
    end
  end
end
