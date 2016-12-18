require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = build(:company, name: "")
        expect(company).to be_invalid
      end

      it "has a unique name" do
        create(:company, name: "Dropbox")
        company = build(:company, name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = build(:company)
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = build(:company)
      expect(company).to respond_to(:jobs)
    end

    it "has many contacts" do
      company = build(:company)
      expect(company).to respond_to(:contacts)
    end
  end
end
