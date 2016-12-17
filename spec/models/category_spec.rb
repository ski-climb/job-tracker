require 'rails_helper'

describe Category do
  describe "validations" do
    context "invalid attributes" do
      it "is invalide without a title" do
        category = build(:category, title: "")
        expect(category).to be_invalid
      end

      it "has a case-insensitive unique title" do
        create(:category, title: "Education")
        category = build(:category, title: "education")
        expect(category).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a unique name" do
        category = build(:category)
        expect(category).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      category = build(:category)
      expect(category).to respond_to(:jobs)
    end
  end
end
