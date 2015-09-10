require 'spec_helper'

describe Archive do
  it { should belong_to(:book) }
  it { should belong_to(:user) }
end