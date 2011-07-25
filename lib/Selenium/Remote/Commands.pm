package Selenium::Remote::Commands;

use strict;
use warnings;

sub new {
    my $class = shift;
    
    # http://code.google.com/p/selenium/wiki/JsonWireProtocol
    my $self = {
        'status'     => {
                          'method' => 'GET',
                          'url'    => 'status'
        },
        'newSession' => {
                          'method' => 'POST',
                          'url'    => 'session'
        },
        'getCapabilities' => {
                          'method' => 'GET',
                          'url'    => 'session/:sessionId'
        },
        'setImplicitWaitTimeout' => {
                        'method' => 'POST',
                        'url'    => 'session/:sessionId/timeouts/implicit_wait'
        },
        'quit' => {
                    'method' => 'DELETE',
                    'url'    => "session/:sessionId"
        },
        'getCurrentWindowHandle' => {
                 'method' => 'GET',
                 'url' => "session/:sessionId/window_handle"
        },
        'getWindowHandles' => {
                'method' => 'GET',
                'url' => "session/:sessionId/window_handles"
        },
        'getCurrentUrl' => {
                           'method' => 'GET',
                           'url' => "session/:sessionId/url"
        },
        'get' => {
                   'method' => 'POST',
                   'url'    => "session/:sessionId/url"
        },
        'goForward' => {
                       'method' => 'POST',
                       'url' => "session/:sessionId/forward"
        },
        'goBack' => {
                      'method' => 'POST',
                      'url'    => "session/:sessionId/back"
        },
        'refresh' => {
                       'method' => 'POST',
                       'url' => "session/:sessionId/refresh"
        },
        'executeScript' => {
                       'method' => 'POST',
                       'url' => "session/:sessionId/execute"
        },
        'screenshot' => {
                    'method' => 'GET',
                    'url' => "session/:sessionId/screenshot"
        },
        'switchToFrame' => {
                'method' => 'POST',
                'url' => "session/:sessionId/frame"
        },
        'switchToWindow' => {
             'method' => 'POST',
             'url' => "session/:sessionId/window"
        },
        'getAllCookies' => {
                        'method' => 'GET',
                        'url' => "session/:sessionId/cookie"
        },
        'addCookie' => {
                        'method' => 'POST',
                        'url' => "session/:sessionId/cookie"
        },
        'deleteAllCookies' => {
                        'method' => 'DELETE',
                        'url' => "session/:sessionId/cookie"
        },
        'deleteCookieNamed' => {
             'method' => 'DELETE',
             'url' => "session/:sessionId/cookie/:name"
        },
        'getPageSource' => {
                        'method' => 'GET',
                        'url' => "session/:sessionId/source"
        },
        'getTitle' => {
                        'method' => 'GET',
                        'url' => "session/:sessionId/title"
        },
        'findElement' => {
                       'method' => 'POST',
                       'url' => "session/:sessionId/element"
        },
        'findElements' => {
                      'method' => 'POST',
                      'url' => "session/:sessionId/elements"
        },
        'getActiveElement' => {
                'method' => 'POST',
                'url' => "session/:sessionId/element/active"
        },
        'describeElement' => {
                'method' => 'POST',
                'url' => "session/:sessionId/element/:id"
        },
        'findChildElement' => {
            'method' => 'POST',
            'url' => "session/:sessionId/element/:id/element"
        },
        'findChildElements' => {
            'method' => 'POST',
            'url' => "session/:sessionId/element/:id/elements"
        },
        'clickElement' => {
               'method' => 'POST',
               'url' => "session/:sessionId/element/:id/click"
        },
        'submitElement' => {
              'method' => 'POST',
              'url' => "session/:sessionId/element/:id/submit"
        },
        'getElementValue' => {
               'method' => 'GET',
               'url' => "session/:sessionId/element/:id/value"
        },
        'sendKeysToElement' => {
               'method' => 'POST',
               'url' => "session/:sessionId/element/:id/value"
        },
        'isElementSelected' => {
            'method' => 'GET',
            'url' => "session/:sessionId/element/:id/selected"
        },
        'setElementSelected' => {
            'method' => 'POST',
            'url' => "session/:sessionId/element/:id/selected"
        },
        'toggleElement' => {
              'method' => 'POST',
              'url' => "session/:sessionId/element/:id/toggle"
        },
        'isElementEnabled' => {
             'method' => 'GET',
             'url' => "session/:sessionId/element/:id/enabled"
        },
        'getElementLocation' => {
            'method' => 'GET',
            'url' => "session/:sessionId/element/:id/location"
        },
        'getElementLocationInView' => {
            'method' => 'GET',
            'url' => "session/:sessionId/element/:id/location_in_view"
        },
        'getElementTagName' => {
                'method' => 'GET',
                'url' => "session/:sessionId/element/:id/name"
        },
        'clearElement' => {
               'method' => 'POST',
               'url' => "session/:sessionId/element/:id/clear"
        },
        'getElementAttribute' => {
            'method' => 'GET',
            'url' =>
"session/:sessionId/element/:id/attribute/:name"
        },
        'elementEquals' => {
            'method' => 'GET',
            'url' => "session/:sessionId/element/:id/equals/:other"
        },
        'isElementDisplayed' => {
            'method' => 'GET',
            'url' => "session/:sessionId/element/:id/displayed"
        },
        'close' => {
                     'method' => 'DELETE',
                     'url'    => "session/:sessionId/window"
        },
        'dragElement' => {
                'method' => 'POST',
                'url' => "session/:sessionId/element/:id/drag"
        },
        'getElementSize' => {
                'method' => 'GET',
                'url' => "session/:sessionId/element/:id/size"
        },
        'getElementText' => {
                'method' => 'GET',
                'url' => "session/:sessionId/element/:id/text"
        },
        'getElementValueOfCssProperty' => {
            'method' => 'GET',
            'url' => "session/:sessionId/element/:id/css/:propertyName"
        },
        'hoverOverElement' => {
               'method' => 'POST',
               'url' => "session/:sessionId/element/:id/hover"
        },
        'mouseMoveToLocation' => {
               'method' => 'POST',
               'url' => "session/:sessionId/moveto"
        },
        #'setVisible' => {
        #               'method' => 'POST',
        #               'url' => "session/:sessionId/visible"
        #},
        #'getVisible' => {
        #               'method' => 'GET',
        #               'url' => "session/:sessionId/visible"
        #},
    };

    bless $self, $class or die "Can't bless $class: $!";
    return $self;
}

# This method will replace the template & return
sub get_params {
    my ($self, $args) = @_;
    if (!(defined $args->{'session_id'})) {
        return;
    }
    my $data = {};
    my $command = $args->{'command'};
    my $url = $self->{$command}->{'url'};
    
    # Do the var substitutions.
    $url =~ s/:sessionId/$args->{'session_id'}/;
    $url =~ s/:id/$args->{'id'}/;
    $url =~ s/:name/$args->{'name'}/;
    $url =~ s/:propertyName/$args->{'property_name'}/;
    $url =~ s/:other/$args->{'other'}/;

    $data->{'method'} = $self->{$command}->{'method'};
    $data->{'url'}    = $url;

    return $data;
}

1;

__END__

=head1 SEE ALSO

For more information about Selenium , visit the website at
L<http://code.google.com/p/selenium/>.

=head1 BUGS

The Selenium issue tracking system is available online at
L<http://github.com/aivaturi/Selenium-Remote-Driver/issues>.

=head1 AUTHOR

Perl Bindings for Selenium Remote Driver by Aditya Ivaturi <ivaturi@gmail.com>

=head1 LICENSE

Copyright (c) 2010 Aditya Ivaturi

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
