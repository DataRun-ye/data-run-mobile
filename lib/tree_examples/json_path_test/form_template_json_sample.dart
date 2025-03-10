// Map<String, dynamic> formSampleForJsonPath = {
//   'uid': 'H111PfAo8kh',
//   'code': 'inventoryForm',
//   'name': 'inventoryForm',
//   'description': 'inventoryForm description',
//   'disabled': false,
//   'activity': 'HZS0PfAo8kh',
//   'version': 4,
//   'default_local': 'en',
//   'fields': [
//     {
//       'order': 1,
//       'name': 'regionInfo',
//       'description': 'regionInfo section description',
//       'type': 'Section',
//       'mandatory': true,
//       'rules': [],
//       'label': {
//         'en': 'Main Info',
//         'ar': 'بيانات المكان'
//       },
//       'fields': [
//         {
//           'order': 1,
//           'name': 'region',
//           'description': 'region description',
//           'type': 'SelectOne',
//           'mandatory': true,
//           'rules': [],
//           'listName': 'regions',
//           'label': {
//             'en': 'Region',
//             'ar': 'المنطقة'
//           },
//           'fields': []
//         },
//         {
//           'order': 2,
//           'name': 'country',
//           'description': 'country',
//           'type': 'SelectOne',
//           'mandatory': true,
//           'rules': [],
//           'listName': 'countries',
//           'choiceFilter': 'regionFilter == #{region}',
//           'label': {
//             'en': 'Country',
//             'ar': 'الدولة'
//           },
//           'fields': []
//         },
//         {
//           'order': 3,
//           'name': 'warehouse',
//           'type': 'SelectOne',
//           'mandatory': true,
//           'rules': [],
//           'listName': 'warehouses',
//           'choiceFilter': 'countryFilter == #{country}',
//           'label': {
//             'en': 'Warehouse',
//             'ar': 'المخزن'
//           },
//           'fields': []
//         }
//       ]
//     },
//     {
//       'order': 2,
//       'name': 'transactionInfo',
//       'description': 'transaction Info description',
//       'type': 'Section',
//       'mandatory': true,
//       'rules': [],
//       'label': {
//         'en': 'Transaction Info',
//         'ar': 'معلومات الحركة'
//       },
//       'fields': [
//         {
//           'order': 1,
//           'name': 'transaction',
//           'type': 'SelectOne',
//           'mandatory': true,
//           'mainField': true,
//           'rules': [],
//           'listName': 'transactions',
//           'label': {
//             'en': 'transactions',
//             'ar': 'نوع الحركة'
//           },
//           'fields': []
//         },
//         {
//           'order': 2,
//           'name': 'transactionDate',
//           'type': 'Date',
//           'mandatory': true,
//           'mainField': true,
//           'rules': [],
//           'label': {
//             'en': 'transaction Date',
//             'ar': 'تاريخ الحركة'
//           },
//           'fields': []
//         },
//         {
//           'order': 3,
//           'name': 'voucherId',
//           'type': 'Integer',
//           'mandatory': true,
//           'mainField': true,
//           'rules': [
//             {
//               'expression': "#{transaction} == 'supply' || #{transaction} == 'dispense' || #{transaction} == 'return'",
//               'action': 'Show'
//             }
//           ],
//           'label': {
//             'en': 'voucherId',
//             'ar': 'رقم الفاتورة'
//           },
//           'fields': []
//         },
//         {
//           'order': 4,
//           'name': 'voucherDate',
//           'type': 'Date',
//           'mandatory': true,
//           'mainField': true,
//           'rules': [
//             {
//               'expression': "#{transaction} == 'supply' || #{transaction} == 'dispense' || #{transaction} == 'return'",
//               'action': 'Show'
//             }
//           ],
//           'label': {
//             'en': 'voucherDate',
//             'ar': 'تاريخ الفاتورة'
//           },
//           'fields': []
//         },
//         {
//           'order': 5,
//           'name': 'supplier',
//           'type': 'Text',
//           'mandatory': true,
//           'mainField': true,
//           'rules': [
//             {
//               'expression': "#{transaction} == 'supply'",
//               'action': 'Show'
//             }
//           ],
//           'label': {
//             'en': 'supplier',
//             'ar': 'المورد'
//           },
//           'fields': []
//         },
//         {
//           'order': 6,
//           'name': 'distinationWarehouse',
//           'type': 'OrganisationUnit',
//           'mandatory': true,
//           'mainField': true,
//           'rules': [
//             {
//               'expression': "#{transaction} == 'dispense' || #{transaction} == 'return'",
//               'action': 'Show'
//             }
//           ],
//           'label': {
//             'en': 'distinationWarehouse',
//             'ar': 'الجهة'
//           },
//           'fields': []
//         }
//       ]
//     },
//     {
//       'order': 3,
//       'name': 'stockItems',
//       'description': 'RepeatableSection description',
//       'type': 'RepeatableSection',
//       'rules': [],
//       'label': {
//         'en': 'Stock Items Data',
//         'ar': 'عناصر الحركة'
//       },
//       'fields': [
//         {
//           'order': 1,
//           'name': 'itemType',
//           'type': 'SelectOne',
//           'mandatory': true,
//           'rules': [],
//           'listName': 'stockItems',
//           'label': {
//             'en': 'Item Type',
//             'ar': 'نوع العنصر'
//           },
//           'fields': []
//         },
//         {
//           'order': 2,
//           'name': 'quantityReceived',
//           'type': 'Integer',
//           'mandatory': true,
//           'rules': [
//             {
//               'expression': '#{transaction} >= 10',
//               'action': 'Error'
//             },
//             {
//               'expression': "#{transaction} == 'supply'",
//               'action': 'Show'
//             }
//           ],
//           'label': {
//             'en': 'Quantity Received',
//             'ar': 'الكمية المستلمة'
//           },
//           'fields': []
//         },
//         {
//           'order': 3,
//           'name': 'quantityDispensed',
//           'type': 'Integer',
//           'mandatory': true,
//           'rules': [
//             {
//               'expression': '#{transaction} >= 10',
//               'action': 'Error'
//             },
//             {
//               'expression': "#{transaction} == 'dispense' || #{transaction} == 'return'",
//               'action': 'Show'
//             }
//           ],
//           'label': {
//             'en': 'Quantity Dispensed/Returned',
//             'ar': 'الكمية المصروفة أو المرتجعة'
//           },
//           'fields': []
//         },
//         {
//           'order': 4,
//           'name': 'uom',
//           'type': 'SelectOne',
//           'mandatory': true,
//           'rules': [],
//           'listName': 'uoms',
//           'label': {
//             'en': 'UOM',
//             'ar': 'الوحدة'
//           },
//           'fields': []
//         }
//       ]
//     }
//   ],
//   'options': [
//     {
//       'listName': 'warehouses',
//       'name': 'Warehouse A',
//       'properties': {
//         'countryFilter': 'us'
//       }
//     },
//     {
//       'listName': 'regions',
//       'name': 'northAmerica',
//       'properties': {}
//     },
//     {
//       'listName': 'regions',
//       'name': 'europe',
//       'properties': {}
//     },
//     {
//       'listName': 'stockItems',
//       'name': 'ACT20MG',
//       'order': 4,
//       'label': {
//         'en': 'ACT20MG',
//         'ar': 'كوارتم 20'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'countries',
//       'name': 'us',
//       'properties': {
//         'regionFilter': 'northAmerica'
//       }
//     },
//     {
//       'listName': 'uoms',
//       'name': 'Ampoule',
//       'order': 4,
//       'label': {
//         'en': 'Ampoule',
//         'ar': 'امبولة'
//       },
//       'properties': {
//         'stockItemFilter': 'ARTING60MG'
//       }
//     },
//     {
//       'listName': 'countries',
//       'name': 'ca',
//       'properties': {
//         'regionFilter': 'northAmerica'
//       }
//     },
//     {
//       'listName': 'countries',
//       'name': 'de',
//       'properties': {
//         'regionFilter': 'europe'
//       }
//     },
//     {
//       'listName': 'transactions',
//       'name': 'consumption',
//       'order': 6,
//       'label': {
//         'en': 'consumption',
//         'ar': 'استهلاك'
//       },
//       'properties': {
//         'age': 0,
//         'phone': '',
//         'code': ''
//       }
//     },
//     {
//       'listName': 'uoms',
//       'name': 'Kit25Test',
//       'order': 1,
//       'label': {
//         'en': 'Kit25Test',
//         'ar': 'كت 25 شريط'
//       },
//       'properties': {
//         'stockItemFilter': 'DRDT'
//       }
//     },
//     {
//       'listName': 'stockItems',
//       'name': 'PMQ15MG',
//       'order': 9,
//       'label': {
//         'en': 'PMQ15MG',
//         'ar': 'بريماكوين 15 مجم'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'transactions',
//       'name': 'return',
//       'order': 4,
//       'label': {
//         'en': 'return',
//         'ar': 'مرتجع'
//       },
//       'properties': {
//         'age': 0,
//         'phone': '',
//         'code': ''
//       }
//     },
//     {
//       'listName': 'uoms',
//       'name': 'Tape6Tablets',
//       'order': 6,
//       'label': {
//         'en': 'Tape 6 Tablets',
//         'ar': 'شريط 6 اقراص'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'countries',
//       'name': 'fr',
//       'properties': {
//         'regionFilter': 'europe'
//       }
//     },
//     {
//       'listName': 'uoms',
//       'name': 'Tablet',
//       'order': 7,
//       'label': {
//         'en': 'Tablet',
//         'ar': 'قرص'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'transactions',
//       'name': 'dispense',
//       'order': 3,
//       'label': {
//         'en': 'dispense',
//         'ar': 'صرف'
//       },
//       'properties': {
//         'age': 0,
//         'phone': '',
//         'code': ''
//       }
//     },
//     {
//       'listName': 'uoms',
//       'name': 'cassette',
//       'order': 3,
//       'label': {
//         'en': 'cassette',
//         'ar': 'كاست'
//       },
//       'properties': {
//         'stockItemFilter': 'DRDT',
//         'transactionFilter': [
//           'dispense',
//           'return',
//           'expiry'
//         ]
//       }
//     },
//     {
//       'listName': 'warehouses',
//       'name': 'Warehouse B',
//       'properties': {
//         'countryFilter': 'ca'
//       }
//     },
//     {
//       'listName': 'warehouses',
//       'name': 'Warehouse C',
//       'properties': {
//         'countryFilter': 'de'
//       }
//     },
//     {
//       'listName': 'warehouses',
//       'name': 'Warehouse D',
//       'properties': {
//         'countryFilter': 'fr'
//       }
//     },
//     {
//       'listName': 'uoms',
//       'name': 'Kit10Test',
//       'order': 2,
//       'label': {
//         'en': 'Kit10Test',
//         'ar': 'كت 10 اشرطة'
//       },
//       'properties': {
//         'stockItemFilter': 'DRDT',
//         'transactionFilter': 'supply'
//       }
//     },
//     {
//       'listName': 'stockItems',
//       'name': 'PMQ7.5MG',
//       'order': 8,
//       'label': {
//         'en': 'PMQ7.5MG',
//         'ar': 'بريماكوين 7.5 مجم'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'transactions',
//       'name': 'inventory',
//       'order': 1,
//       'label': {
//         'en': 'Inventory',
//         'ar': 'جرد'
//       },
//       'properties': {
//         'age': 0,
//         'phone': '',
//         'code': ''
//       }
//     },
//     {
//       'listName': 'stockItems',
//       'name': 'MRDT',
//       'order': 5,
//       'label': {
//         'en': 'MRDT',
//         'ar': 'الفحص السريع للملاريا'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'stockItems',
//       'name': 'DRDT',
//       'order': 6,
//       'label': {
//         'en': 'DRDT',
//         'ar': 'الفحص السريع للضنك'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'transactions',
//       'name': 'supply',
//       'order': 2,
//       'label': {
//         'en': 'Supply',
//         'ar': 'توريد'
//       },
//       'properties': {
//         'age': 0,
//         'phone': '',
//         'code': ''
//       }
//     },
//     {
//       'listName': 'transactions',
//       'name': 'expiry',
//       'order': 5,
//       'label': {
//         'en': 'expiry',
//         'ar': 'منتهي'
//       },
//       'properties': {
//         'age': 0,
//         'phone': '',
//         'code': ''
//       }
//     },
//     {
//       'listName': 'uoms',
//       'name': 'Tape10Tablets',
//       'order': 5,
//       'label': {
//         'en': 'Tape10Tablets',
//         'ar': 'شريط 10 اقراص'
//       },
//       'properties': {
//         'stockItemFilter': 'PMQ7.5MG'
//       }
//     },
//     {
//       'listName': 'stockItems',
//       'name': 'ACT40MG',
//       'order': 3,
//       'label': {
//         'en': 'ACT40MG',
//         'ar': 'كوارتم 40'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'stockItems',
//       'name': 'ACT80MG',
//       'order': 1,
//       'label': {
//         'en': 'ACT80MG',
//         'ar': 'كوارتم 80'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'stockItems',
//       'name': 'ACT60MG',
//       'order': 2,
//       'label': {
//         'en': 'ACT60MG',
//         'ar': 'كوارتم 60'
//       },
//       'properties': {}
//     },
//     {
//       'listName': 'stockItems',
//       'name': 'ARTING60MG',
//       'order': 7,
//       'label': {
//         'en': 'ARTING60MG',
//         'ar': 'ارتيسونات 60 مجم امبول'
//       },
//       'properties': {}
//     }
//   ],
//   'option_sets': [
//     {
//       'list_name': 'regions',
//       'options': [
//         {
//           'listName': 'regions',
//           'name': 'northAmerica',
//           'properties': {}
//         },
//         {
//           'listName': 'regions',
//           'name': 'europe',
//           'properties': {}
//         }
//       ]
//     },
//     {
//       'list_name': 'countries',
//       'options': [
//         {
//           'listName': 'countries',
//           'name': 'us',
//           'properties': {
//             'regionFilter': 'northAmerica'
//           }
//         },
//         {
//           'listName': 'countries',
//           'name': 'ca',
//           'properties': {
//             'regionFilter': 'northAmerica'
//           }
//         },
//         {
//           'listName': 'countries',
//           'name': 'de',
//           'properties': {
//             'regionFilter': 'europe'
//           }
//         },
//         {
//           'listName': 'countries',
//           'name': 'fr',
//           'properties': {
//             'regionFilter': 'europe'
//           }
//         }
//       ]
//     },
//     {
//       'list_name': 'stockItems',
//       'options': [
//         {
//           'listName': 'stockItems',
//           'name': 'ACT80MG',
//           'order': 1,
//           'label': {
//             'en': 'ACT80MG',
//             'ar': 'كوارتم 80'
//           },
//           'properties': {}
//         },
//         {
//           'listName': 'stockItems',
//           'name': 'ACT60MG',
//           'order': 2,
//           'label': {
//             'en': 'ACT60MG',
//             'ar': 'كوارتم 60'
//           },
//           'properties': {}
//         },
//         {
//           'listName': 'stockItems',
//           'name': 'ACT40MG',
//           'order': 3,
//           'label': {
//             'en': 'ACT40MG',
//             'ar': 'كوارتم 40'
//           },
//           'properties': {}
//         },
//         {
//           'listName': 'stockItems',
//           'name': 'ACT20MG',
//           'order': 4,
//           'label': {
//             'en': 'ACT20MG',
//             'ar': 'كوارتم 20'
//           },
//           'properties': {}
//         },
//         {
//           'listName': 'stockItems',
//           'name': 'MRDT',
//           'order': 5,
//           'label': {
//             'en': 'MRDT',
//             'ar': 'الفحص السريع للملاريا'
//           },
//           'properties': {}
//         },
//         {
//           'listName': 'stockItems',
//           'name': 'DRDT',
//           'order': 6,
//           'label': {
//             'en': 'DRDT',
//             'ar': 'الفحص السريع للضنك'
//           },
//           'properties': {}
//         },
//         {
//           'listName': 'stockItems',
//           'name': 'ARTING60MG',
//           'order': 7,
//           'label': {
//             'en': 'ARTING60MG',
//             'ar': 'ارتيسونات 60 مجم امبول'
//           },
//           'properties': {}
//         },
//         {
//           'listName': 'stockItems',
//           'name': 'PMQ7.5MG',
//           'order': 8,
//           'label': {
//             'en': 'PMQ7.5MG',
//             'ar': 'بريماكوين 7.5 مجم'
//           },
//           'properties': {}
//         },
//         {
//           'listName': 'stockItems',
//           'name': 'PMQ15MG',
//           'order': 9,
//           'label': {
//             'en': 'PMQ15MG',
//             'ar': 'بريماكوين 15 مجم'
//           },
//           'properties': {}
//         }
//       ]
//     },
//     {
//       'list_name': 'warehouses',
//       'options': [
//         {
//           'listName': 'warehouses',
//           'name': 'Warehouse A',
//           'properties': {
//             'countryFilter': 'us'
//           }
//         },
//         {
//           'listName': 'warehouses',
//           'name': 'Warehouse B',
//           'properties': {
//             'countryFilter': 'ca'
//           }
//         },
//         {
//           'listName': 'warehouses',
//           'name': 'Warehouse C',
//           'properties': {
//             'countryFilter': 'de'
//           }
//         },
//         {
//           'listName': 'warehouses',
//           'name': 'Warehouse D',
//           'properties': {
//             'countryFilter': 'fr'
//           }
//         }
//       ]
//     },
//     {
//       'list_name': 'transactions',
//       'options': [
//         {
//           'listName': 'transactions',
//           'name': 'inventory',
//           'order': 1,
//           'label': {
//             'en': 'Inventory',
//             'ar': 'جرد'
//           },
//           'properties': {
//             'age': 0,
//             'phone': '',
//             'code': ''
//           }
//         },
//         {
//           'listName': 'transactions',
//           'name': 'supply',
//           'order': 2,
//           'label': {
//             'en': 'Supply',
//             'ar': 'توريد'
//           },
//           'properties': {
//             'age': 0,
//             'phone': '',
//             'code': ''
//           }
//         },
//         {
//           'listName': 'transactions',
//           'name': 'dispense',
//           'order': 3,
//           'label': {
//             'en': 'dispense',
//             'ar': 'صرف'
//           },
//           'properties': {
//             'age': 0,
//             'phone': '',
//             'code': ''
//           }
//         },
//         {
//           'listName': 'transactions',
//           'name': 'return',
//           'order': 4,
//           'label': {
//             'en': 'return',
//             'ar': 'مرتجع'
//           },
//           'properties': {
//             'age': 0,
//             'phone': '',
//             'code': ''
//           }
//         },
//         {
//           'listName': 'transactions',
//           'name': 'expiry',
//           'order': 5,
//           'label': {
//             'en': 'expiry',
//             'ar': 'منتهي'
//           },
//           'properties': {
//             'age': 0,
//             'phone': '',
//             'code': ''
//           }
//         },
//         {
//           'listName': 'transactions',
//           'name': 'consumption',
//           'order': 6,
//           'label': {
//             'en': 'consumption',
//             'ar': 'استهلاك'
//           },
//           'properties': {
//             'age': 0,
//             'phone': '',
//             'code': ''
//           }
//         }
//       ]
//     },
//     {
//       'list_name': 'uoms',
//       'options': [
//         {
//           'listName': 'uoms',
//           'name': 'Kit25Test',
//           'order': 1,
//           'label': {
//             'en': 'Kit25Test',
//             'ar': 'كت 25 شريط'
//           },
//           'properties': {
//             'stockItemFilter': 'DRDT'
//           }
//         },
//         {
//           'listName': 'uoms',
//           'name': 'Kit10Test',
//           'order': 2,
//           'label': {
//             'en': 'Kit10Test',
//             'ar': 'كت 10 اشرطة'
//           },
//           'properties': {
//             'stockItemFilter': 'DRDT',
//             'transactionFilter': 'supply'
//           }
//         },
//         {
//           'listName': 'uoms',
//           'name': 'cassette',
//           'order': 3,
//           'label': {
//             'en': 'cassette',
//             'ar': 'كاست'
//           },
//           'properties': {
//             'stockItemFilter': 'DRDT',
//             'transactionFilter': [
//               'dispense',
//               'return',
//               'expiry'
//             ]
//           }
//         },
//         {
//           'listName': 'uoms',
//           'name': 'Ampoule',
//           'order': 4,
//           'label': {
//             'en': 'Ampoule',
//             'ar': 'امبولة'
//           },
//           'properties': {
//             'stockItemFilter': 'ARTING60MG'
//           }
//         },
//         {
//           'listName': 'uoms',
//           'name': 'Tape10Tablets',
//           'order': 5,
//           'label': {
//             'en': 'Tape10Tablets',
//             'ar': 'شريط 10 اقراص'
//           },
//           'properties': {
//             'stockItemFilter': 'PMQ7.5MG'
//           }
//         },
//         {
//           'listName': 'uoms',
//           'name': 'Tape6Tablets',
//           'order': 6,
//           'label': {
//             'en': 'Tape 6 Tablets',
//             'ar': 'شريط 6 اقراص'
//           },
//           'properties': {}
//         },
//         {
//           'listName': 'uoms',
//           'name': 'Tablet',
//           'order': 7,
//           'label': {
//             'en': 'Tablet',
//             'ar': 'قرص'
//           },
//           'properties': {}
//         }
//       ]
//     }
//   ],
//   'orgUnits': [],
//   'label': {
//     'en': 'Malaria Drugs Supply',
//     'ar': 'توزيع أدوية الملاريا'
//   },
//   '_class': 'org.nmcpye.datarun.drun.mongo.domain.DataForm'
// };
