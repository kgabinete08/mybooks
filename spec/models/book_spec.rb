require 'spec_helper'

describe Book do
  it { should validate_presence_of(:title) }
  it { should belong_to(:category) }
  it { should have_many(:reviews).order("created_at DESC") }
end