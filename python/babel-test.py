#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
from babel import Locale

# NOTE:  'my' dropped as the Burmese characters won't display on my Mac
for language in ('ga','ru','ar','fa','zh','en'):
    locale = Locale(language)
    print('<tr>')
    print('<td>' + language + '</td>')

    for country in ('IE','RU','LY','IR','MM','HK','US'):
        print('<td>' + locale.territories[country] + '</td>')

    print('</tr>')
