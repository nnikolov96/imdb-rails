module Features
  def select_date_and_time(date, options = {})
    field = options[:from]
    select date.strftime('%Y'),  :from => "#{field}_1i" #year
    select date.strftime('%B'),  :from => "#{field}_2i" #month
    select date.strftime('%-d'), :from => "#{field}_3i" #day 
    select date.strftime('%H'),  :from => "#{field}_4i" #hour
    select date.strftime('%M'),  :from => "#{field}_5i" #minute
  end

  def select_date(date, options = {})
    field = options[:from]
    select date.strftime('%Y'),  :from => "#{field}_1i" #year
    select date.strftime('%B'),  :from => "#{field}_2i" #month
    select date.strftime('%-d'), :from => "#{field}_3i" #day 
  end

  def sign_in_as(email, password)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on "Submit"
  end
end 