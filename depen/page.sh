#!/bin/bash
sed -e 's@</head>@<script src='"'"C_4"'"'></script></head>@g' <'index2.html' >'index.html'
