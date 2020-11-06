crumb :root do
  link "トップページ", root_path
end

crumb :post do
  link  "記事詳細", post_path
  parent :root
end

crumb :user do |user|
  link user.nickname, user_path(user)
  parent :post
end



crumb :following_user do
  link "フォロ一", following_user_path
  parent :user
end

crumb :followers_user do
  link "フォロワー", followers_user_path
  parent :user
end




# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).