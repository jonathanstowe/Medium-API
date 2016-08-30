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

is $obj.title, "Liverpool FC", "correct title";
is $obj.publish-status, "public", "publish status correct";
is $obj.content-format, "html", "content-format";
is $obj.content, "<h1>Liverpool FC</h1><p>You’ll never walk alone.</p>", "content";
is $obj.canonical-url, "http://jamietalbot.com/posts/liverpool-fc", "canonical-url";
is $obj.license, "all-rights-reserved", "license (correct default)";
is-deeply [$obj.tags], ["football", "sport", "Liverpool"], "tags are the same";

my $out;

lives-ok { $out = $obj.to-json }, "to-json";

lives-ok { $obj = Medium::API::Post.new(title => "test title", content => "<h1>Foo</h1>", content-format => "html", tags => <one two three>) }, "new from scratch";
is $obj.title, "test title", "correct title";
is $obj.publish-status, "public", "publish status correct default";
is $obj.content-format, "html", "content-format";
is $obj.content, "<h1>Foo</h1>", "content";
is $obj.license, "all-rights-reserved", "license (correct default)";
is-deeply [$obj.tags], [<one two three>], "tags were set right";

lives-ok { $out = $obj.to-json }, "to-json";

throws-like { $obj = Medium::API::Post.new(title => "zz" x 101, content => "<h1>Foo</h1>", content-format => "html") }, X::TypeCheck::Assignment, "title constraint";

throws-like { $obj = Medium::API::Post.new(title => "text title" , content => "<h1>Foo</h1>", content-format => "html", tags => [ "a" x 30]) }, X::TypeCheck::Assignment, "tags constraint";

done-testing;
# vim: expandtab shiftwidth=4 ft=perl6
