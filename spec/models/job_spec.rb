require 'rails_helper'

describe Job do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = build(:job, title: "")
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = build(:job, level_of_interest: "")
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = build(:job, city: "")
        expect(job).to be_invalid
      end

      it "is invalid without a category" do
        job = build(:job, category_id: nil)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, a city and level of interest" do
        job = build(:job)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = build(:job)
      expect(job).to respond_to(:company)
    end

    it "belongs to a category" do
      job = build(:job)
      expect(job).to respond_to(:category)
    end

    it "has many comments" do
      job = build(:job)
      expect(job).to respond_to(:comments)
    end
  end

  describe "#company_name" do
    it "returns the company name" do
      job = build(:job)
      expect(job.company_name).to eq job.company.name
    end
  end

  describe "#category_name" do
    it "returns the category title" do
      job = build(:job)
      expect(job.category_title).to eq job.category.title
    end
  end
end
