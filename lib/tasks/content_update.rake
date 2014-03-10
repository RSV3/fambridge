namespace :content_update do
  desc "Update an article on homepage by removing one and adding one"
  task update_home_content: :environment do
    c_old = Content.where(slug: "irrational-caregiving")[0]
    c_old.homepage = false
    old_order = c_old.homepage_order
    c_old.homepage_order = nil
    c_old.save

    c_new = Content.where(slug: "mom-has-a-boyfriend")[0]
    c_new.homepage = true
    c_new.homepage_order = old_order
    c_new.save
  end

end
