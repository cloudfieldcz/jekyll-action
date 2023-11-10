# jekyll-action

This action is meant to be used when building a jekyll site that is to be pushed to an S3 buckets.
## How to Use

**1. Add steps to your workflow**

```yaml
  steps:
  # ...
  - name: Build and Deploy
    uses: cloudfieldcz/jekyll-action@master

  # ...
```

## Output

When this runs you should see something like this:
```
🚩 Checking for expected environment variables
   ✅ SOURCE found: ./_site


🚩 Checking working directory for expected files(/github/workspace)
   ✅ Found jekyll config file


🚩 Installing bundle gems
   ✅ Completed bundle install


🚩 Building jekyll site
   ✅ Jekyll build done


```
