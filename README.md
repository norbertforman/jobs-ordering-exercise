# Jobs ordering exercise

Imagine we have a list of jobs, each represented by a character. Because certain jobs must be done before others, a job may have a dependency on another job. For example, a may depend on b, meaning the final sequence of jobs should place b before a. If a has no dependency, the position of a in the final sequence does not matter.

## Rules

* A job must contain an id
* Self dependency is not allowed
* Circular dependency is not allowed

## Instalation

* clone the project
* install ruby 2.3.1 or a newer version (if you don't have it installed already)
* run bundle install

## Testing

* run bundle exec rspec

## Scanning 
```ruby
jobQueue = JobQueue.new(job_structure)
jobQueue.order
```
