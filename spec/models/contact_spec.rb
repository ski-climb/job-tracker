require 'rails_helper'

describe Contact do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        contact = build(:contact, name: "")
        expect(contact).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name, an email, and a company" do
        contact = build(:contact)
        expect(contact).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      contact = build(:contact)
      expect(contact).to respond_to(:company)
    end
  end

  describe "#company_name" do
    let(:tesla)   { create(:company, name: "Tesla Motors") }
    let(:contact) { create(:contact, company: tesla) }

    it "returns an empty string when there is no company" do
      contact.company = nil

      expect(contact.company_name). to eq ""
    end

    it "returns the company name for the contact" do
      expect(contact.company_name).to eq "Tesla Motors"
    end
  end
end
