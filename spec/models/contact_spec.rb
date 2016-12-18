require 'rails_helper'

describe Contact do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        contact = build(:contact, name: "")
        expect(contact).to be_invalid
      end

      it "is invalid without an email" do
        contact = build(:contact, email: "")
        expect(contact).to be_invalid
      end

      it "is invalid without a company" do
        contact = build(:contact, company: nil)
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
end
