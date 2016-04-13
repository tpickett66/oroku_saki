require 'spec_helper'

describe OrokuSaki do
  it 'has a version number' do
    expect(OrokuSaki::VERSION).not_to be nil
  end

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
end
