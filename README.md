<p align="center">
  <img src="./static/images/gopher_full.png" alt="Gitrob" width="200" />
</p>
<br />
<br />
<br />

# Gitrob: Putting the Open Source in OSINT

Gitrob is a tool to help find potentially sensitive files pushed to public repositories on Github. Gitrob will clone repositories belonging to a GitLab or Github user or group/organization down to a configurable depth and iterate through the commit history and flag files and/or commit content that match signatures for potentially sensitive information. The findings will be presented through a web interface for easy browsing and analysis.

## Usage

    gitrob [options] target [target2] ... [targetN]

### Options

```
-bind-address string
    Address to bind web server to (default "127.0.0.1")
-commit-depth int
    Number of repository commits to process (default 500)
-debug
    Print debugging information
-github-access-token string
    Github access token to use for API requests (set one)
-gitlab-access-token string
    GitLab access token to use for API requests (set one)
-in-mem-clone
    Clone repositories into memory for faster analysis depending on your hardware
-load string
    Load session file from specified path
-mode int {1, 2, or 3}
    Designate a mode for execution.  Mode 1 (default) searches for file signature matches.  Mode 2 (-mode 2) searches for file signature matches.  Given a file signature match, mode 2 then attempts to match on content in order to produce a result.  Mode 3 (-mode 3) searches by content matches only.  In mode 3, no file signature matches are performed.
-no-expand-orgs
    Don't add members to targets when processing organizations
-port int
    Port to run web server on (default 9393)
-save string
    Save session to a file at the given path
-silent
    Suppress all output except for errors
-threads int
    Number of concurrent threads (default number of logical CPUs)
```

### Saving session to a file

By default, gitrob will store its state for an assessment in memory. This means that the results of an assessment is lost when Gitrob is closed. You can save the session to a file by using the `-save` option:

    gitrob -save ~/gitrob-session.json acmecorp

Gitrob will save all the gathered information to the specified file path as a special JSON document. The file can be loaded again for browsing at another point in time, shared with other analysts or parsed for custom integrations with other tools and systems.

### Loading session from a file

A session stored in a file can be loaded with the `-load` option:

    gitrob -load ~/gitrob-session.json

Gitrob will start its web interface and serve the results for analysis.

## Installation

A [precompiled version is available](https://github.com/michenriksen/gitrob/releases) for each release, alternatively you can use the latest version of the source code from this repository in order to build your own binary.

Make sure you have a correctly configured **Go >= 1.8** environment and that `$GOPATH/bin` is in your `$PATH`

    $ go get github.com/michenriksen/gitrob

This command will download gitrob, install its dependencies, compile it and move the `gitrob` executable to `$GOPATH/bin`.

### Access Tokens

Gitrob will need either a GitLab or Github access token in order to interact with the appropriate API.  You can create a GitLab personal access token, or [a Github personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) and save it in an environment variable in your `.bashrc` or similar shell configuration file:

    export GITROB_GITLAB_ACCESS_TOKEN=deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
    export GITROB_GITHUB_ACCESS_TOKEN=deadbeefdeadbeefdeadbeefdeadbeefdeadbeef

Alternatively you can specify the access token with the `-gitlab-access-token` or `-github-access-token` option on the command line, but watch out for your command history!
