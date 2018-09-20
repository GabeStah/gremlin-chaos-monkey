---
title: "Notes to Gremlin Editors"
description: "A step-by-step guide on setting up and using Chaos Monkey with AWS, and also explores specific scenarios in which Chaos Monkey may (or may not) be relevant."
path: "/chaos-monkey/notes"
url: "https://www.gremlin.com/chaos-monkey/notes"
sources: "See: _docs/resources.md"
published: true
---

The following items are assorted things for Austin and/or other editors to take note of and evaluate.

## Titles

1. During creation, the sections and content of the [Chaos Monkey Resources, Guides, and Downloads][/downloads-resources] evolved to encompass Chaos Engineering in general, as opposed to just Chaos Monkey, as the page title implies.  I recognize the original intent of the title is to capture search traffic based on the "Chaos Monkey" keyword, but editors should consider whether the page title and/or section titles should change, as they are currently not all that congruent.

## Images

1. The following `AWS Spinnaker Quick Start Architecture` image, as used in the [Developer Tutorial][/developer-tutorial], is **copyright of AWS**.  If desired, please recreate image for Gremlin.

    ![developer-tutorial-aws-spinnaker-quick-start-architecture](../images/developer-tutorial-aws-spinnaker-quick-start-architecture.png 'AWS Spinnaker Quick Start Architecture')

2. [The History of Netflix Streaming][#netflix-history] section ends with the line "Thus, the Netflix team began their journey into Chaos."  This might be a good place for a "Journey into Chaos"-style image.
3. Currently, the URL `/pdf-download` is being used to reference the future downloadable PDF version of this guide.  Please change all instances of this URL throughout the guide if the target URL changes as well.
4. The following chart is currently used in the [Simian Army - Chaos Kong][#simian-chaos-kong] section and is **copyright of Netflix**.  Please determine if use, with attribution, should remain or if image should be removed.
    ![simian-army-netflix-chaos-kong-experiment](../images/simian-army-netflix-chaos-kong-experiment.png 'Netflix Chaos Kong Experiment Chart -- Courtesy Netflix')

    *Netflix Chaos Kong Experiment - **Courtesy of Netflix***

5. `Janitor Monkey` paint image seen below and used in [Simian Army - Janitor Monkey][#simian-janitor-monkey] is [copyright of Drawception](https://drawception.com/panel/drawing/hJvv6336/janitor-monkey-laughs-at-spilled-mop-bucket/) user [XII](https://drawception.com/player/477070/xiii/).  But, it made me laugh so I had to include it.  Perhaps something similar can be used here for the guide.

    ![simian-army-janitor-monkey](../images/simian-army-janitor-monkey.png 'A magnificent Janitor Monkey')

## Links

All internal and frequently-used URLs are located in the `_internal/nav-internal.md` template, which is then included via `{% raw %}{% include nav-internal.md %}{% endraw %}` at the end of every Markdown file.  Therefore, to change a link throughout the full guide simply requires changing it in `nav-internal.md` and rebuilding.

### Testing URL Validity and Functionality

1. The `html-proofer` gem is used to help verify link validity.  It can be run manually, but the `Rakefile` is configured to perform a Jekyll build and then execute `html-proofer`.

    ```ruby
    # RAKEFILE
    require 'html-proofer'

    task :test do
        # Temporarily replace baseurl for shared mount directories to hash correctly.
        sh "bundle exec jekyll build --baseurl ''"
        options = {
            assume_extension: true,
            url_ignore: [
            # Documentation link.
            "http://localhost:9000",
            # PDF Download not implemented
            "/pdf-download",
            ]
        }
        HTMLProofer.check_directory("./docs", options).run
    end
    ```

    Execute with standard `rake test` command.

    ```bash
    rake test
    ```

    Errors indicate the specific problem, while a successful output confirms all links are valid and functional.

    ```bash
    Running ["LinkCheck", "ScriptCheck", "ImageCheck"] on ["./docs"] on *.html...

    Checking 105 external links...
    Ran on 16 files!

    HTML-Proofer finished successfully.
    ```

### Gremlin Links

- **(TODO)**: Find out where Gremlin service mention links should point to and update accordingly.
    - For example, where should references to signup for/acquire a Gremlin account point to?  At present, they use the `#gremlin-account-signup` navigation link key, which resolves to [this URL][#gremlin-account-signup].

### External Links

By default, all external links are processes with `target="_blank" rel="noreferrer noopener"` tags, opening them in a new window.  To disable this behavior disable the `jekyll-target-blank` gem and rebuild.

## Resources

1. Google Sheets document found [here](https://docs.google.com/spreadsheets/d/1SeNhnXx6dx7a3Ng4_hDS8LfKty8TVzxTt6g661OB6_E/).
2. Save URLs to `src/_data/resource-urls.csv` and execute `titles` Scrapy spider, specifying full input and output file paths.

    ```bash
    scrapy crawl titles -a input="/mnt/hgfs/work/Gremlin/gremlin-projects/chaos-monkey/src/_data/resource-urls.csv" -t csv --nolog -o - > "/mnt/hgfs/work/Gremlin/gremlin-projects/chaos-monkey/src/_data/resource-titles.csv"
    ```

    > note ""
    > Scraping will be very slow because `CONCURRENT_REQUESTS` and `CONCURRENT_ITEMS` are set to `1`, to maintain the same output order as input order.

3. Paste exported `Titles` into Google Sheet column.

{% include nav-internal.md %}