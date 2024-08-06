
## Generating Translations Files
```
lupdate content/*.cpp content/*.h content/*.qml -ts translations/translations_uk.ts translations/translations_ja.ts
```


## QtLinguist
```
linguist translations/translations_uk.ts
linguist translations/translations_ja.ts
```

## Releasing translation files
```
lrelease translations/translations_uk.ts -qm translations/translations_uk.qm
lrelease translations/translations_ja.ts -qm translations/translations_ja.qm
```