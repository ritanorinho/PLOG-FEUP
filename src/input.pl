insertRow(NumberRow):- readRow(Row),
                 validateRow(Row,NumberRow).

insertColumn(NumberColumn):- readColumn(Column),
                       validateColumn(Column,NumberColumn).

readRow(Row):- write('Row: '),
               read(Row).

readColumn(Column):- write('Column: '),
                     read(Column).

validateColumn('A',NumberColumn):- NumberColumn = 1.
validateColumn('B',NumberColumn):- NumberColumn = 2.
validateColumn('C',NumberColumn):- NumberColumn = 3.
validateColumn('D',NumberColumn):- NumberColumn = 4.
validateColumn('E',NumberColumn):- NumberColumn = 5.
validateColumn('F',NumberColumn):- NumberColumn = 6.
validateColumn('G',NumberColumn):- NumberColumn = 7.
validateColumn('H',NumberColumn):- NumberColumn = 8.
validateColumn(_Column,NumberColumn):- 
    write('Column invalid! Please insert a column between A-G!\n'),
    read(Column),
    validateColumn(Column, NumberColumn).

validateRow('1',NumberRow):- NumberRow = 1.
validateRow('2',NumberRow):- NumberRow = 2.
validateRow('3',NumberRow):- NumberRow = 3.
validateRow('4',NumberRow):- NumberRow = 4.
validateRow('5',NumberRow):- NumberRow = 5.
validateRow('6',NumberRow):- NumberRow = 6.
validateRow('7',NumberRow):- NumberRow = 7.
validateRow('8',NumberRow):- NumberRow = 8.
validateRow(_Row,NumberRow):- 
    write('Row invalid! Please insert a row between 1-8!\n'),
    read(Row),
    validateColumn(Row, NumberRow).