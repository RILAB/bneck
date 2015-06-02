#include <iostream>
#include <sstream>
#include <vector>
#include <cstdio>
#include <numeric>
#include <utility>
#include <Sequence/SimParams.hpp>
#include <Sequence/SimData.hpp>
#include <Sequence/PolySites.hpp>
#include <Sequence/PolySIM.hpp>
#include <Sequence/SeqConstants.hpp>
#include <Sequence/PolyTableFunctions.hpp>
#include <Sequence/PolySNP.hpp>
#include <Sequence/PolyTableSlice.hpp>

using namespace std;
using namespace Sequence;

int main(int argc, char *argv[]) 
{
  	SimParams p;
	SimData d;
	PolySIM P(&d);
	int window_size=0; // change to read from commandline
	int step_size=0; // change to read from commandline
	int alignment_length=0; // change to read from commandline
	
	for(int arg = 1 ; arg < argc ; ++arg)
    	{
   		if( string(argv[arg]) == "-L" )
			alignment_length = atoi(argv[++arg]);
   		else if( string(argv[arg]) == "-w" )
			window_size = atoi(argv[++arg]);
   		else if( string(argv[arg]) == "-s" )
			step_size = atoi(argv[++arg]);
	}
	int rv;
	int physical_scale=alignment_length; // keep this same as alignment_length for simulated ms data 
 	while( (rv=d.fromfile(stdin)) != EOF )
	{
		Sequence::PolyTableSlice<Sequence::PolySites> windows(d.sbegin(),d.send(),window_size,step_size,alignment_length,physical_scale);
      		Sequence::PolyTableSlice<Sequence::PolySites>::const_iterator itr = windows.begin();
        	while(itr < windows.end())
        	{
        		Sequence::PolySites window = windows.get_slice(itr);
           		Sequence::PolySNP analyzeWindow(&window);
			cout << analyzeWindow.ThetaPi()   << '\t' << analyzeWindow.NumSingletons() << '\t';
        	     	++itr;
		}
		cout << '\n';
	}
}	
