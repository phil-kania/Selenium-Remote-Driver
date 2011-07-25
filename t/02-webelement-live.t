use strict;
use warnings;

use Test::More 'no_plan';
use Net::Ping;
use Data::Dumper;

BEGIN {
    my $p = Net::Ping->new("tcp", 2);
    $p->port_number(4444);
    unless ($p->ping('localhost')) {
        BAIL_OUT ("Selenium server is not running on localhost:4444");
        exit;
    }
    unless (use_ok( 'Selenium::Remote::Driver')) {
        BAIL_OUT ("Couldn't load Driver");
        exit;
    }
}

# Start our local http server
if ($^O eq 'MSWin32')
{
   system("start \"TEMP_HTTP_SERVER\" /MIN perl t/http-server.pl");
}
else
{
    system("perl t/http-server.pl > /dev/null &");
}


my $driver = new Selenium::Remote::Driver(browser_name => 'firefox');
my $website = 'http://localhost:63636';
my $ret;
my $elem;

LINK: {
        $driver->get("$website/formPage.html");
        $driver->find_element("//a[\@href='/index.html']")->click;
        pass('Click Link...');
        $ret = $driver->get_title();
        is($ret, 'Hello WebDriver', 'Verify clicked link.');
        $driver->go_back();
      }

INPUT: {
            $elem = $driver->find_element('withText', 'id');
            $ret = $elem->get_text();
            is($ret, 'Example text', 'Get innerText');
            $elem = $driver->find_element('id-name1', 'id');
            $ret = $elem->get_value();
            is($ret, 'id', 'Get value (attribute)');
            $ret = $elem->get_attribute('value');
            is($ret, 'id', 'Get attribute @value');
            $ret = $elem->get_tag_name();
            is($ret, 'input', 'Get tag name');
            
            $elem = $driver->find_element('checky', 'id');
            $ret = $elem->is_selected();
            is($ret, 'false', 'Checkbox not selected');
            $ret = $elem->click();
            $ret = $elem->is_selected();
            is($ret, 'true', 'Checkbox is selected');
            TODO: {
            local $TODO = "toggle doesn't appear to be working currently in selenium server";
            eval {$ret = $elem->toggle();};
            $ret = $elem->is_selected();
            is($ret, 'false', 'Toggle & Checkbox is selected');
            };
       }

IMAGES: {
            $driver->get("$website/dragAndDropTest.html");
            $elem = $driver->find_element('test1', 'id');
            $ret = $elem->get_size();
            is($ret->{'width'}, '18', 'Image - right width');
            is($ret->{'height'}, '18', 'Image - right height');
            $ret = $elem->get_element_location();
            ok(defined $ret->{'x'}, 'Image - got x coord');
            ok(defined $ret->{'y'}, 'Image - got y coord');
            my $x = $ret->{'x'};
            my $y = $ret->{'y'};
            TODO: {
            local $TODO = "drag doesn't appear to be working currently in selenium server";
            eval {$ret = $elem->drag(200,200);};
            $ret = $elem->get_element_location();
            is($ret->{'x'}, ($x+200), 'Moved to new x coord');
            is($ret->{'y'}, ($y+200), 'Moved to new y coord');
            };
        }

QUIT: {
        $ret = $driver->quit();
        ok((not defined $driver->{'session_id'}), 'Killed the remote session');
      }

# Kill our HTTP Server
if ($^O eq 'MSWin32')
{
   system("taskkill /FI \"WINDOWTITLE eq TEMP_HTTP_SERVER\"");
}
else
{
    `ps aux | grep http-server\.pl | grep perl | awk '{print \$2}' | xargs kill`;
}
