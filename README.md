# NmtranEditor
An attempt to create an NMTRAN editor using XText

This is essentially an abandoned attempt to create a NONMEM editor using XText.

The problem with using XText to parse NMTRAN is that NMTRAN does not follow the convensions the XText/Antlr Lexer expects.
The type of a token is determined not by a text pattern alone, but also by its contents.  So for example the text after the
`$PROBLEM` block is treated as a string, and need not be surrounded in quotes, but unquoted text after the $PK block, for example,
must be treated as the name of an identifier.

I couldn't work out a way for XText to handle this without rewriting (and maintaining!) an alternate XText lexer
- something I don't have the time to do.

## Code Status

There are a number of tests provided and everything is setup as a maven build but the tests fail (because of the lexer issue
described above)and the maven build fails too.  I just haven't got round to fixing the depednecy issue.

To use you can run as an Eclipse application or build from Maven:

```
mvn clean install -DskipTests=true
```

