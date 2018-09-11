#!/bin/env perl
use strict;
use warnings;
use FileHandle;
use DBI;
#use Time::Local;
use Getopt::Std;
#use ICDGenevaLog;
use tmb_common;
use DBD::Oracle qw(:ora_types);
use ICDCurrency;
use IPGUtils;
use File::Basename;


use Getopt::Std;
use IPGLog;
use IPGDb;
use ICDSendMail;
#
autoflush STDOUT 2;
autoflush STDERR 2;

 #Global variables
 my $dbObj;
 my $DB;
 my $outDir;
 my $sysDate;
 my $emailAddress;
 my $invoice;
 my $dir="";
 my $Logobj;
 my %help;
 my $versionNbr;

#
#

#****************************** START OF MAIN ******************************
## Command Line aurguments:
##  < -e <email > -i <invoice>>
##  file format is a follows
##  
##***************************************************************************
@ARGV = &normalizeParms(@ARGV);
            print "Running test.pl with command arguments:\n" .
                         "    @ARGV\n";
#
#
 parseArgs();

     $dir = $ENV{"TMO_INVLANDING_DIR"};
	  if (!defined($dir))
	  {
         $dir = readGenevaGParam($DB,'TMO_INVLANDING_DIR');
	      if (!defined($dir))
		  {
              IPGUtils::printHelp( \%help, " TMO_INVLANDING_DIR not defined in env or GenevaGParam " );
              exit 1;
		  }
	  }

my $searchDir="/$invoice"."v$versionNbr*";

my @files = glob( $dir.$searchDir );
#   print "files = @files \n";

 mailReport(@files); #This only emails one report.


#***************************************************************************
## Function    : parseArgs()
## De cription : Process the command line arguments for this script.
## Returns     : None
## ***************************************************************************
sub parseArgs
{
    my  $arguments  = join( " ", @ARGV );
    # Get rid of Geneva parms
    my @systemArgs = IPGUtils::normalizeParms();
    $Logobj = ICDGenevaLog->new();

    $help{ appName }        = "CSRPurgeScript Application";
    $help{ description }    = "This application emails a invoice file ";
#    $help{ notes }          = "The application uses only two environment variable: \$DATABASE.  It needs to be of the format:  export DATABASE=user/password\@sid";
    $help{ options }{ e }{ argVal }   = "Email File";
    $help{ options }{ i }{ argVal }   = "Invoice";

    if( !Getopt::Std::getopts( 'e:i' ) )
    {
        IPGUtils::printHelp( \%help, "Invalid argument passed (missing argument to flag?)" );
    }

    my  $shutUpWarnings;
    $shutUpWarnings = $Getopt::Std::opt_e;
    $shutUpWarnings = $Getopt::Std::opt_i;

    my $regex;
    $dbObj = IPGDb->new();
    $DB= $dbObj->getDbh();
 
    if( defined( $Getopt::Std::opt_e ) )
    {
        $emailAddress = $Getopt::Std::opt_e;
         
        $regex = $emailAddress =~ /^[a-z0-9.]+\@[a-z0-9.-]+$/;
  
         if ($regex eq "")
           {
              IPGUtils::printHelp( \%help, " Email Address invalid" );
              exit 1;
           } 

        print("email = $emailAddress \n");
    }
    else
    {
         IPGUtils::printHelp( \%help, "Missing Email Address " );
         exit 1;
    }
 
    if( defined( $Getopt::Std::opt_i ) )
    {
        $invoice = $Getopt::Std::opt_i;
        $invoice = "@ARGV";             #this is needed to make it work, but the obove should work but doesn't seem to.
        print("invoice = $invoice \n");
        validateInvoice($invoice);
 
      print "versionNbr = $versionNbr \n";

     if ( $versionNbr == 0 )
         {
             IPGUtils::printHelp( \%help, " Invoice # not in Bill Summary table." );
             exit 1;
         }
       
    }
    else
    {
         IPGUtils::printHelp( \%help, "Missing Invoice Number " );
         exit 1;
    }

}


#*********************************************************************
## Function    : _mailReport(),  Created: 2009/03/01
## Description : Mails the report off to the specified email address.
## Returns     :
## Notes       :
##********************************************************************
sub mailReport
{
 #   my  $self                   = shift;
    my @reportFiles = @ARGV;
    my  $reportFileNameAndPath  = shift;

    # Only mail the report if they want it.
    if( $reportFileNameAndPath )
    {
	my $file= basename($reportFileNameAndPath);
	print "file = $file \n";
	print "reportFileNameAndPath = $reportFileNameAndPath \n";

        my  $subject    = "Invoice Report $invoice";
        my  $message    = "Dear T-Mobile,\n"
                            . "\n"
                            . "Please find the attached invoice.\n"
                            . "\n"
                            . "CVG IPS\n"
                            ;
        ICDSendMail::SendEMail( $emailAddress,
                                $subject,
                                $message,
                                $reportFileNameAndPath,
                                $file);

#        $LogObj->logInform( 2, "Report mailed off" );
        IPGUtils::printHelp( \%help, "  Report mailed off " );
    }
    else
    {
#        $LogObj->logInform( 1, "Report NOT mailed off, as requested." );
         IPGUtils::printHelp( \%help, " Report NOT found and not mailed. " );
    }
}


#***************************************************************************
## Function    : validateInvoice
## Description : valadates the invlice is on the  billsummary table
## Returns     : versionNbr
## Notes       :
##***************************************************************************
#
sub validateInvoice
{
    my $invoice = $ _[0];
    my $outCnt=0;
    my $rc;
    eval{
        my $sth = $DB->prepare(" select max(bill_version) from billsummary where invoice_num = '$invoice' ") ;
                             #or die $Logobj->logError("Can't prepare statement: $DBI::errstr \n");

#        $sth->bind_param(":gname", $gname);
#        $sth->bind_param_inout(":outdir", \$outdir,200);
        $rc = $sth->execute();
        $outCnt =  $sth->fetchrow;
         print "outCnt = $outCnt\n";
        $sth->finish();
         $versionNbr=$outCnt;
      
        return $outCnt;
     };
     if ($@)
     {
         $Logobj->logError($DB->errstr);
         $versionNbr=$outCnt;
         return $outCnt;
     }
}
