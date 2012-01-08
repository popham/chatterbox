YUI.add('chatterbox', function (Y) {
    Y.Chatter = Y.Base.create('chatter', Y.Widget, [Y.WidgetChild], {
        BOUNDING_TEMPLATE : '<li class="chatterbox-partner"></li>',
        CONTENT_TEMPLATE : null,
        
        initializer : function (conf) {
            this.set('userId', conf.userId);
            this.set('username', conf.username);
            this.set('lastTouch', conf.lastTouch);
        },
        
        usernameMarkup : function () {
            var tokens = {
                username : this.get("username"),
                usernameClass : this.getClassName("username")
            },
                template = '<span class="{usernameClass}">{username}</span>';

            return Y.substitute(template, tokens);
        },

        partnerInfoChild1 : function () {
            return this.usernameMarkup();
        },

        partnerInfoChild2 : function () { return ""; },

        renderUI : function () {
            var tokens = {
                avatarClass : this.getClassName("avatar", this.get("userId").toString()),
                partnerInfoClass : this.getClassName("partner", "info"),
                child1 : this.partnerInfoChild1(),
                child2 : this.partnerInfoChild2()
            },
                template = '<div class="{avatarClass}" /><div class="{partnerInfoClass}">{child1}{child2}</div>',
                children = Y.substitute(template, tokens);

            return children;
        }

        // Chat instance eventually
        //_conversation : null
    }, {
        CSS_PREFIX : 'chatterbox',
        ATTRS : {
            userId : {
                value : -1
            },
            username : {
                value : ''
            },
            lastTouch : {
                value : 0
            }
        }
    });

    Y.RecentChatter = Y.Base.create("RecentChatter", Y.Chatter, [], {
        /*
          renderAvatar : function () {
          var classes = {
          avatar     : this.getClassName("avatar", this.get('userId').toString()),
          unanswered : this.getClassName("unanswered", this.unansweredN)
          },
          template = '<div class="{avatar}" />';

          return Y.substitute(template, classes);
          }
        */
    }, {
        _lastTouch : function (now, then) {
            var minutes, hours, days, years;

            minutes = (now - then) / 60000.0;
            if (minutes < 60.0) {
                return minutes.parseInt() + "m";
            }

            hours = minutes / 60.0;
            minutes = minutes - Math.floor(hours) * 60.0;
            if (hours < 24.0) {
                return hours.parseInt() + "h + " + minutes.parseInt() + "m";
            } else if (hours < 25.0) {
                return "1d & " + minutes.parseInt() + "m";
            }

            days = hours / 24.0;
            hours = hours - Math.floor(days) * 24.0;
            if (days < 365.25) {
                return days.parseInt() + "d + " + hours.parseInt() + "h";
            }

            years = days / 365.25;
            days = days - Math.floor(years) * 365.25;
            return years.parseInt() + "y + " + days.parseInt() + "d";
        }
    });

    Y.ChatterBox = Y.Base.create('chatterbox', Y.Widget, [Y.WidgetParent], {
        BOUNDING_TEMPLATE : '<div class="chatterbox-widget"></div>',
        CONTENT_TEMPLATE : '<ol></ol>',

        initializer : function (config) {
            YUI().use('io-base', function (Y) {
                var callbacks = {
                    on : {
                        start : function (transactionId, args) {
                            // Transition from Unloaded state to Loading state
                            
                        },
                        success : function (transactionId, response, args) {
                            // Transition from Loading state to Loaded state
                            
                            /* Example Successful Response Data 
                            var availableConversations = [
                                {
                                    userId : '1270003',
                                    username : 'memothy',
                                    lastTouch : '1322924954'
                                },
                                {
                                    userId : '1272838',
                                    username : 'batman',
                                    lastTouch : '1322894954'
                                },
                                {
                                    userId : '1262333',
                                    username : 'greenlantern',
                                    lastTouch : '1322874954'
                                },
                                {
                                    userId : '1262373',
                                    username : 'schemer',
                                    lastTouch : '1322844954'
                                },
                                {
                                    userId : '1289923',
                                    username : 'littleschemer',
                                    lastTouch : '1322824954'
                                }
                            ];
                            */
                            /*
                            for (var i=0; i<availableConversations.length; i++) {
                                var chatter;
                                if (i < this.get('numberOfRecentChatters')) {
                                    chatter = new Y.RecentChatter(availableConversations[i]);
                                } else {
                                    chatter = new Y.Chatter(availableConversations[i]);
                                }

                                this.add(chatter);
                            }
                            */
                        },
                        failure : function (transactionId, response, args) {
                            // Transition from Loading state to Unloadable state
                            
                        }
                    }
                };

                var request = Y.io(config.conversationsUrl, callbacks);
            });
        }
/*
        destructor : function () {
            
        },

        renderUI : function () {
            
        },
*/
/*        bindUI : function () {
            this.get('boundingBox').plug(Y.Plugin.NodeFocusManager, {
                descendants : "." + someClassName,
                keys : {
                    next : 'down:40',
                    previous : 'down:38'
                },
                circular : false
            });

            this.on('option:keydown', function (event) {
                
            });
        },*/
/*
        syncUI : function () {
            
        }*/
    }, {
        CSS_PREFIX : 'chatterbox',
        ATTRS : {
            numberOfRecentChatters : {
                value : 5,
                validator : function (value) {
                    return !/^[0-9]/.test(value.toString());
                }
            }
        }

        /*    RECENT_PARTNER_TEMPLATE : '<li class="{recentPartnerClassName}"><div class="{avatarClassName}"><div class="{unansweredCardinalityClassName}" /></div><div class="{partnerInfoClassName}"><span class="{usernameClassName}">{username}</span>&nbsp;-<br /><span class="{lastTouchClassName}">{lastTouch}</span></div></li>',

              AVAILABLE_PARTNER_TEMPLATE : '<li class="{availablePartnerClassName}"><div class="{avatarClassName}" /><div class="{partnerInfoClassName}"><span class="{usernameClassName}">{username}</span></div></li>'
        */
    });
}, '0.1', {
    requires : ['substitute', 'widget', 'widget-parent', 'widget-child', 'io-base']
});
