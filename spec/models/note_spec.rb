require 'spec_helper'

describe Note do
  it { should belong_to(:user) }
  it { should belong_to(:book) }
end