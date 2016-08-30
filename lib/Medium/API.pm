use v6.c;

use IO::Socket::SSL;
use HTTP::UserAgent;
use JSON::Name;
use JSON::Class;

class Medium::API {
    has Str $.integration-token;

    
    class UserAgent is HTTP::UserAgent {
        has Str $.integration-token is required;

        method auth-header() {
            "Bearer " ~ $!integration-token;
        }

        method !build-headers(*%extra) returns HTTP::Header {
            my $header = HTTP::Header.new;

            $header.field(Content-Type => 'application/json; charset=utf-8');
            $header.field(Accept => 'application/json');
            $header.field(Authorization => self.auth-header);

            $header;
        }
    }

    has UserAgent $.ua;

    method ua() returns UserAgent {
        $!ua //= UserAgent.new(:$!integration-token);
    }

    class Post does JSON::Class {
        subset PublishStatus of Str where "public"|"draft"|"unlisted";
        has PublishStatus $.publish-status is json-name('publishStatus') = "public";
        subset Title of Str where .chars <= 100 ;
        has Title $.title is required;
        subset ContentFormat of Str where "html"|"markdown";
        has ContentFormat $.content-format is json-name('contentFormat') is required;
        has Str $.content is required;
        subset Tag of Str where .chars < 26;
        has Tag @.tags;
        has Str $.canonical-url  is json-name('canonicalUrl') is json-skip-null;
        subset Licence of Str where "all-rights-reserved"|"cc-40-by"|"cc-40-by-sa"|"cc-40-by-nd"|"cc-40-by-nc"|"cc-40-by-nc-nd"|"cc-40-by-nc-sa"|"cc-40-zero"|"public-domain";
        has Licence $.license = "all-rights-reserved";
    }

    class User does JSON::Class {
        class Data does JSON::Class {
            has Str $.id;
            has Str $.name;
            has Str $.image-url is json-name('imageUrl');
            has Str $.username;
            has Str $.url;
        }
        has Data $.data handles *;
    }

    class Publications does Positional does JSON::Class {
        class Publication does JSON::Class {
            has Str $.id;
            has Str $.name;
            has Str $.description;
            has Str $.image-url is json-name('imageUrl');
            has Str $.url;
        }
        has Publication @.data handles *;
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
