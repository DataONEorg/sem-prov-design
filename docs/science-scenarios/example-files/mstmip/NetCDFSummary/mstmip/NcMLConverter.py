
import csv
import os
import sys
from io import BytesIO
import cStringIO
from urlparse import urlparse
import xml.etree.ElementTree as XMLParser
import pycurl
import codecs

class NcMLConverter(object):
    '''Convert NcML metadata files produced by ncdump to a summarized CSV table.'''
    
        
    def __init__(self, input_file_path, output_file_path):
        '''Constructor: Builds an instance of the NcMLConverter class'''
        
        self.ncml_url_file_path = input_file_path
        self.ncml_csv_file_path = output_file_path
        self.rows = list()
        self.row = list() # Add a header row
        self.row.append('netcdf_file_name')
        self.row.append('dimension_name')
        self.row.append('dimension_length')
        self.row.append('dimension_is_unlimited')
        self.row.append('variable_name')
        self.row.append('variable_type')
        self.row.append('variable_shape')
        self.row.append('attribute_name')
        self.row.append('attribute_value')
        self.row.append('ncml_url')
        self.rows.append(self.row)
                                
    
    def convert(self):
        '''Process the NCML documents to create a table (list of lists)'''
        
        try:
            with open(self.ncml_url_file_path, 'r') as urls:
                
                for url in urls:
                    ncml_bytes = BytesIO()
                    print('Reading {}'.format(url))
                    curl = pycurl.Curl()
                    curl.setopt(curl.URL, url.strip())
                    curl.setopt(curl.WRITEDATA, ncml_bytes)
                    try:
                        curl.perform()
                        
                        #=======================================================
                        # # create a local file path
                        # url_parts = urlparse(url.strip())
                        # url_path_list = url_parts.path.split('/')
                        # file_name = url_path_list[len(url_path_list) - 1]
                        #=======================================================
                        
                        #=======================================================
                        # url_path_list = url_path_list[2:len(url_path_list)]
                        # full_file_path = os.path.join('..', 'output', *url_path_list)
                        # full_dir_path = os.path.dirname(full_file_path)
                        #=======================================================
                        
                        # make the directory if it doesn't exist
                        #=======================================================
                        # if not os.path.exists(full_dir_path):
                        #     os.makedirs(full_dir_path, 0770)
                        #     
                        # with open(full_file_path, 'w') as xml_file:
                        #     all_bytes = bytearray(ncml_bytes.getvalue(), errors='replace')
                        #     xml_file.write(all_bytes)
                        #     
                        # xml_file.close()       
                        #=======================================================
                        
                        # Ignore bytes not in the UTF-8 character sets
                        ncml = ncml_bytes.getvalue()
                        decoded_ncml = ncml.decode('utf-8', errors='ignore')
                        ncml_str = decoded_ncml.encode('utf-8') 
                        ncml_str = ncml_str.strip()
                        
                        if ncml_str == '': # Some documents originated as 1 byte (\n) 
                            print 'Skipping empty file'
                            continue
                        
                        ncml_document = XMLParser.fromstring(ncml_str)
                        ns = '{http://www.unidata.ucar.edu/namespaces/netcdf/ncml-2.2}'
                        
                        # Find the NetCDF file name
                        netcdf_attrs = ncml_document.attrib
                        try:
                            file_name = netcdf_attrs['location']
                        except:
                            file_name = ''
                                
                        # Add netcdf/dimension
                        for dimension in ncml_document.findall(ns + 'dimension'):
                            self.row = list() # Intitialize a CSV table row
                            self.row.append(file_name)
                            dimension_attrs = dimension.attrib
                            try:
                                self.row.append(dimension_attrs['name'])
                            except:
                                self.row.append('')
                            try:
                                self.row.append(dimension_attrs['length'])
                            except:
                                self.row.append('')
                            try:
                                self.row.append(dimension_attrs['isUnlimited'])
                            except:
                                self.row.append('')
                            self.row.append('')
                            self.row.append('')
                            self.row.append('')
                            self.row.append('')
                            self.row.append('')
                            self.row.append(url.strip())
                            self.rows.append(self.row)
                         
                        # Add netcdf/attribute         
                        for attribute in ncml_document.findall(ns + 'attribute'):                            
                            self.row = list() # Intitialize a CSV table row
                            self.row.append(file_name)
                            self.row.append('')
                            self.row.append('')
                            self.row.append('')
                            self.row.append('')
                            self.row.append('')
                            self.row.append('')
                            attribute_attrs = attribute.attrib
                            try:
                                self.row.append(attribute_attrs['name'])
                            except:
                                self.row.append('')
                            try:
                                self.row.append(attribute_attrs['value'])
                            except:
                                self.row.append('')
                            self.row.append(url.strip())
                            self.rows.append(self.row)
                        
                        # Add netcdf/variable 
                        for variable in ncml_document.findall(ns + 'variable'):
                            for attribute in variable.findall(ns + 'attribute'):                            
                                self.row = list()
                                self.row.append(file_name)
                                self.row.append('')
                                self.row.append('')
                                self.row.append('')
                                variable_attrs =  variable.attrib
                                try:
                                    self.row.append(variable_attrs['name'])
                                except:
                                    self.row.append('')
                                try:
                                    self.row.append(variable_attrs['type'])
                                except:
                                    self.row.append('')
                                try:
                                    self.row.append(variable_attrs['shape'])
                                except:
                                    self.row.append('')
                                attribute_attrs =  attribute.attrib
                                try:
                                    self.row.append(attribute_attrs['name'])
                                except:
                                    self.row.append('')
                                try:
                                    self.row.append(attribute_attrs['value'])
                                except:
                                    self.row.append('')
                                self.row.append(url.strip())
                                self.rows.append(self.row)
                                                                                        
                    except UnicodeError, e:
                        print(e)
                        
                    else:
                        curl.close()
                        
        
        except IOError, e:
            print(e)
    
    
    def writeToFile(self):
        '''Write the NcML table to a CSV file'''
        
        with open(self.ncml_csv_file_path, 'w') as csv_file:
            csv_file.write(codecs.BOM_UTF8)
            
            #ncml_writer = csv.writer(csv_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_ALL)
            ncml_writer = UnicodeWriter(csv_file)
            
            for row in self.rows:
                print row
                ncml_writer.writerow(row)
                
        csv_file.close()
        

class UnicodeWriter:
    """
    A CSV writer which will write rows to CSV file "f",
    which is encoded in the given encoding.
    """

    def __init__(self, f, dialect=csv.excel, encoding="utf-8", **kwds):
        # Redirect output to a queue
        self.queue = cStringIO.StringIO()
        self.writer = csv.writer(self.queue, dialect=dialect, **kwds)
        self.stream = f
        self.encoder = codecs.getincrementalencoder(encoding)()

    def writerow(self, row):
        self.writer.writerow([s.encode("utf-8") for s in row])
        # Fetch UTF-8 output from the queue ...
        data = self.queue.getvalue()
        data = data.decode("utf-8")
        # ... and reencode it into the target encoding
        data = self.encoder.encode(data)
        # write to the target stream
        self.stream.write(data)
        # empty queue
        self.queue.truncate(0)

    def writerows(self, rows):
        for row in rows:
            self.writerow(row)
            
                    
def main():
    '''Creates and runs an instance of the NcMLConverter class'''

    ncml_url_file_path = '../mstmip-ncml-urls.txt'
    ncml_csv_file_path = '../mstmip-ncml-summary.csv'

    converter = NcMLConverter(ncml_url_file_path, ncml_csv_file_path)
    converter.convert()
    converter.writeToFile()
    
    
# Run the main method of the module if called from the command line
if __name__ == '__main__':
    sys.exit(main())
        