
## Generating Translations Files
```
lupdate content/*.cpp content/*.h content/*.qml -ts translations/translations_uk.ts translations/translations_ja.ts translations/translations_en.ts
```


## QtLinguist
```
linguist translations/translations_uk.ts
linguist translations/translations_ja.ts
linguist translations/translations_en.ts
```

## Releasing translation files
```
lrelease translations/translations_uk.ts -qm translations/translations_uk.qm
lrelease translations/translations_ja.ts -qm translations/translations_ja.qm
lrelease translations/translations_en.ts -qm translations/translations_en.qm
```
