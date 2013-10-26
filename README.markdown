# Sample Nitrogen Plugin

This is a basic skeleton of a plugin for the [Nitrogen Web
Framework](http://nitrogenproject.com), which introduced a plugin system in
version 2.2.0.

There is some general documentation on working with Nitrogen plugins in the
[Nitrogen Documentation](http://nitrogenproject.com/doc/plugins.html).

This, however, is more specific to creating an effective Nitrogn plugin for
reuse in your systems and others.

## Introduction

Nitrogen plugins are Erlang applications formatted in a certain way, and can be
set up as rebar dependencies. As long as the application is a valid rebar
dependency, and has a file called nitrogen.plugin in the root of the directory,
then it'll be treated as a plugin by the standard Nitrogen Makefile.

Most Nitrogen plugins will be custom Nitrogen elements, though they can be as
simple or as elaborate as needed, including adding dependency services and
applications.

## Adding a Nitrogen Plugin to Your Nitrogen App (post 2.2.0)

Modify your rebar.config file and add to the `deps` section the following:

```erlang
{my_plugin, ".*", {git, "git://github.com/nitrogen/sample_nitrogen_plugin.git", {branch, master}}}
```

Then run `make` in your application.

This will do the following:
  + Download the plugin source and add it as a dependency.
  + Import any of the contents of the plugin's `include/` directory, linking to
    each found .hrl file in the application's `plugins.hrl` file.
  + Copy (or symlink) the contents of the plugin's `static/` directory.
  + Recompile the application's source code

## Tree Structure

The basic tree structure of a Nitrogen plugin is as follows:

```
.
├── ebin
├── include
│   └── records.hrl
├── nitrogen.plugin
├── priv
│   └── static
│       ├── css
│       │   └── style.css
│       ├── images
│       └── js
│           └── plugin.js
└── src
    ├── element_sample_nitrogen_plugin.erl
    └── sample_nitrogen_plugin.app.src
```

### ebin/

This is the standard target for the compiled Erlang .beam files (and the .app
file generated from the .app.src file)

### include/

This will be where you will have any include files. Any .hrl files found in
here will be automatically referenced by the Nitrogen `do-plugins` script, and
imported into each page in your application.

### include/records.hrl

This will be your record definitions. For example:

```erlang
-record(sample_nitrogen_plugin, {?ELEMENT_BASE(element_sample_nitrogen_plugin), field1, field2 }).
```

Note, that we do not need to add `-include_lib("nitrogen_core/include/wf.hrl)`
to this because that will be included in each page anyway.

### src/

Like any good Erlang app, this will be where you put your Erlang module source
files, such as your element rendering modules.  Additionally, the .app.src file
will typically go here.

An element rendering module should look something like this:

```erlang
-module (element_sample_nitrogen_plugin).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

-export([
    reflect/0,
    render_element/1
]).

reflect() -> record_info(fields, sample_nitrogen_plugin).

render_element(_Rec = #sample_nitrogen_plugin{}) ->
    [
        <<"Hello! This is a sample Nitrogen Plugin">>
    ].
```

**A few things about includes:**

  + `-include_lib("nitrogen_core/include/wf.hrl").` Should still exist to
    import all Nitrogen elements.
  + `-include("records.hrl").` This is actually pointing at the `records.hrl`
    file found in the *plugin's* directory, not the general `records.hrl` file
in your application's directory.

### priv/static/

This will be the location of static resources: images, javascript files,
stylesheets, or anything else for that matter.

The contents of this directory will be either copied (or symlinked) into
static/plugins/plugin_name

## Read More

Read about [Nitrogen Plugins](http://nitrogenproject.com/doc/plugins.html)
