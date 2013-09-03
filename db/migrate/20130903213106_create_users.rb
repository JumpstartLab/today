class CreateUsers < ActiveRecord::Migration
  def change
    create_table 'users' do |t|
      t.string 'name'
      t.string 'email'
      t.string 'location'
      t.string 'username'
      t.integer 'github_id'
      t.string 'avatar_url'
      t.string 'gravatar_id'
      t.boolean 'is_admin', default: false

      t.timestamps
    end
  end
end
