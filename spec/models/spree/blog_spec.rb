require 'rails_helper'

describe Spree::Blog do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :seo_title }
  it { should validate_presence_of :meta_keywords }
  it { should validate_presence_of :meta_description }
end
