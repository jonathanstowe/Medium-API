#!/usr/bin/env perl6

use v6.c;

use Test;

use Medium::API;

my $json = q:to/EOJ/;
{
  "title": "Liverpool FC",
  "contentFormat": "html",
  "content": "<h1>Liverpool FC</h1><p>You’ll never walk alone.</p>",
  "canonicalUrl": "http://jamietalbot.com/posts/liverpool-fc",
  "tags": ["football", "sport", "Liverpool"],
  "publishStatus": "public"
}
EOJ

my $obj;

lives-ok { $obj = Medium::API::Post.from-json($json) }, "a Medium::API::Post from json";

is $obj.publish-status, "public", "publish status correct";
is $obj.content-format, "html", "content-format";
is $obj.content, "<h1>Liverpool FC</h1><p>You’ll never walk alone.</p>", "content";
is $obj.canonical-url, "http://jamietalbot.com/posts/liverpool-fc", "canonical-url";
is $obj.license, "all-rights-reserved", "license (correct default)";
is-deeply $obj.tags, ["football", "sport", "Liverpool"], "tags are the same";




done-testing;
# vim: expandtab shiftwidth=4 ft=perl6
