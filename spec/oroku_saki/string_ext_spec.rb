require 'spec_helper'

module OrokuSaki
  RSpec.describe StringExt do
    it 'must add String#shred!' do
      expect('my string').to respond_to(:shred!)
    end

    it 'must shred a String that receives #shred!' do
      str = 'my string'
      length = str.length
      str.shred!
      expect(str).to eq Array.new(length, "\u0000").join
    end

    it 'must add String#shred_later' do
      expect('').to respond_to(:shred_later)
    end
  end
end
