# ActionSentinelGroup

Control of group access permissions to controller actions using [ActionSentinel](https://github.com/denisstael/action_sentinel).
## Installation

### 1. Add the gem into your project

Add this to your Gemfile and run `bundle install`.

```ruby
gem 'action_sentinel_group'
```

Or install it yourself as:
```sh
gem install action_sentinel_group
```

### 2. Generate Models

Use the ActionSentinelGroup generator to create the required models and its migrations. This generator expects that you already have a user model. 

You must specify the name of the user model and the name of the model that will represent the group of users. For example, if the name of your user model is `User` and you want a group model called `Group`, you can call:
```
rails g action_sentinel_group:install User Group
```

If your database uses UUID for the primary and foreign keys, you can pass the `--uuid` option:

```
rails g action_sentinel_group:install User Group --uuid
```

The generator will create the group model with the name that you provided (in this example it will be `Group`), it will also create a model called `UserGroup` (the junction between your user model name and the group model), create the migrations and will insert into your User class the required methods to check the user's groups access permissions.

It will invoke the [generator from ActionSentinel](https://github.com/denisstael/action_sentinel#2-generate-accesspermission-model) to create `AccessPermission` model and insert into Group model the required methods to manage access permissions.

Finally, it will create an initializer file with the required configurations.

### 3. Run the migrations

You can check the migrations created into your migrations folder, and add custom fields before running them if necessary.
```
rails db:migrate
```

## Usage

### Managing permissions to the group

You can add manage permissions to a group at the same way that is informed by [ActionSentinel](https://github.com/denisstael/action_sentinel#usage):

```ruby
# Adding permissions to access create and update actions in UsersController
group.add_permissions_to 'create', 'update', 'users'

# Removing permissions to access create and update actions in UsersController
group.remove_permissions_to 'create', 'update', 'users'

# Checking if the group have permission to access create action in UsersController
group.has_permission_to? 'create', 'users'
```

### Check permissions for a user of the group

You can associate a user to a group that have permissions to acces actions of some controllers, and you can check if the user have the pemission to access some action of a controller, in the same way that you check the group permission:

```ruby
# Associating the user with the group
UserGroup.create(user_id: user.id, group_id: group.id)

# Giving permission to the group to action 'create' of a controller called PostsController
group.add_permissions_to('create', 'posts')

# Checking if the user has permission to access the action 'create' of a controller called PostsController
user.has_permission_to?('create', 'posts')
```

## Authorization

To controllers authorization and another configurations about authorization methods, you can follow the instructions provided by the documentation of ActionSentinel gem:

- [Include authorization in ApplicationController](https://github.com/denisstael/action_sentinel#4-include-authorization-in-applicationcontroller)
- [Authorization method](https://github.com/denisstael/action_sentinel#authorization)
- [Action User](https://github.com/denisstael/action_sentinel#action-user)
- [Rescuing an UnauthorizedAction in ApplicationController](https://github.com/denisstael/action_sentinel#rescuing-an-unauthorizedaction-in-applicationcontroller)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/denisstael/action_sentinel_group.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
