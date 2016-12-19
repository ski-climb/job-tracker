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

  describe ".by_level_of_interest" do
    it "returns jobs sorted by level of interest, highest first" do
      job_3 = create(:job, level_of_interest: 30)
      job_1 = create(:job, level_of_interest: 10)
      job_2 = create(:job, level_of_interest: 20)

      expect(Job.by_level_of_interest).to eq [job_3, job_2, job_1]
    end
  end

  describe ".by_location" do
    it "returns jobs sorted by location in aphabetical order" do
      job_3 = create(:job, city: "Zebra Town")
      job_1 = create(:job, city: "Allen Town")
      job_2 = create(:job, city: "Moors Town")

      expect(Job.by_location).to eq [job_1, job_2, job_3]
    end
  end

  describe ".for_location" do
    it "returns jobs for that city only" do
      job_3 = create(:job, city: "Tucson")
      job_1 = create(:job, city: "Denver")
      job_2 = create(:job, city: "Tucson")

      expect(Job.for_location("Tucson")).to eq [job_3, job_2]
    end
  end

  describe ".count_by_location" do
    it "returns jobs for that city only" do
      job_3 = create(:job, city: "Tucson")
      job_1 = create(:job, city: "Denver")
      job_2 = create(:job, city: "Tucson")

      expect(Job.count_by_location).to eq({"Tucson" => 2, "Denver" => 1})
    end
  end

  describe ".count_by_level_of_interest" do
    it "returns jobs for that city only" do
      create(:job, level_of_interest: 33)
      create(:job, level_of_interest: 33)
      create(:job, level_of_interest: 13)
      create(:job, level_of_interest: 13)
      create(:job, level_of_interest: 13)
      create(:job, level_of_interest: 53)

      expect(Job.count_by_level_of_interest).to eq({53 => 1, 33 => 2, 13 => 3})
    end
  end

  describe ".highest_ranked_companies" do
    it "returns the companies ordered according to the average level of interest of their jobs, highest first" do
      company_1 = create(:company)
      company_2 = create(:company)
      create(:job, level_of_interest: 20, company: company_1)
      create(:job, level_of_interest: 35, company: company_1)
      create(:job, level_of_interest: 35, company: company_1)
      create(:job, level_of_interest: 30, company: company_2)
      create(:job, level_of_interest: 45, company: company_2)
      create(:job, level_of_interest: 45, company: company_2)

      expect(Job.highest_ranked_companies).to eq [[40, company_2.name], [30, company_1.name]]
    end

    it "limits the results to three companies" do
      company_1 = create(:company)
      company_2 = create(:company)
      company_3 = create(:company)
      company_4 = create(:company)
      create(:job, level_of_interest: 20, company: company_1)
      create(:job, level_of_interest: 35, company: company_2)
      create(:job, level_of_interest: 35, company: company_3)
      create(:job, level_of_interest: 30, company: company_4)
      create(:job, level_of_interest: 45, company: company_1)
      create(:job, level_of_interest: 45, company: company_2)

      result = Job.highest_ranked_companies
      expect(result.length).to eq 3
    end
  end

end
