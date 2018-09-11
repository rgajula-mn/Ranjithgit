package com.convergys.custom.geneva.j2ee.billingProfile;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class SendInvoiceByEmailDao {
	private Util util;

	private static TraceLog traceLog = new TraceLog(SendInvoiceByEmailDao.class);

	public SendInvoiceByEmailDao() {
		traceLog.traceFinest(" SendInvoiceByEmail:..!!!!!!! ");
	}

	public String sendInvoiceByMail(com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String invoiceNumber, java.lang.String mailId) throws ApplicationException {

		traceLog.traceFinest("Entering into sendInvoiceByMail : ");
		String result = null;
		try {
			traceLog.traceFinest(
					"Entered into QueryInvoiceSummary API. invoiceNumber:" + invoiceNumber + " mailId: " + mailId);

			if (integratorContext == null || integratorContext.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.SEND_INVOICE_BYMAIL);
			}
			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.SEND_INVOICE_BYMAIL);
			}
			if (invoiceNumber == null || invoiceNumber.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_13000, Constants.SEND_INVOICE_BYMAIL);
			}
			if (mailId == null || mailId.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_13001, Constants.SEND_INVOICE_BYMAIL);
			}
			//Removing Email validation from ECA as this validation is already being done in Portal
			/*if (!(isValiedEmail(mailId))) {
				throw new ApplicationException(ErrorCodes.ERR_RBM_13002 + Constants.SEND_INVOICE_BYMAIL);
			}*/

			String str[] = validateInvoiceNumber(invoiceNumber);

			String version;
			if (str != null && str[0] == null) {
				throw new ApplicationException(ErrorCodes.ERR_RBM_13004 + " " + Constants.SEND_INVOICE_BYMAIL);
			}
			if (str[1] == null) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_13006, Constants.SEND_INVOICE_BYMAIL);
			} else {
				version = str[1];
			}

			String filePath = executeQueryForPath("EMAIL_FILE_PATH");
			if (filePath == null || filePath.isEmpty()) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_13005, Constants.SEND_INVOICE_BYMAIL);
			}
			traceLog.traceFinest("File Path : " + filePath);
			File targetFile = null;
			if (Integer.parseInt(version) == 1) {
				targetFile = new File(filePath + invoiceNumber + ".rtf");
			} else {
				targetFile = new File(filePath + invoiceNumber + "v" + version + ".rtf");
			}
			traceLog.traceFinest("fileInputStream ::  " + targetFile);

			String command = "echo \"Dear T-Mobile, \n\n Please find the attached invoice. \n\n CVG IPS\" | mailx -s \"Invoice Report-"
					+ invoiceNumber + "\" -r \"NetcrackerMVNOBillingAdmin@netcracker.com\" -a " + targetFile + " "
					+ mailId;
			Runtime r = Runtime.getRuntime();
			traceLog.traceFinest("Envoi de la commande: " + command);
			Process process = r.exec(new String[] { "/usr/bin/ksh", "-c", command });
			traceLog.traceFinest("process Value : " + process.waitFor());
			if (process.exitValue() == 0) {
				result = "E-Mail is Successfully sent to: " + mailId;
			} else {
				result = "Faild to send Email.";
				throw new ApplicationException(ErrorCodes.ERR_RBM_13003 + result);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			traceLog.traceFinest("Exception from  sendInvoiceByMail API : " + ex.getMessage());
			throw new ApplicationException(ErrorCodes.ERR_RBM_13003 + ex.getMessage().toString());
		}
		traceLog.traceFinest("End of the sendInvoiceByMail : ");
		return result;
	}

	public boolean isValiedEmail(String mailId) {
		String regex = "^[a-zA-Z0-9.-_]+\\@[a-zA-Z0-9.-]+$"; // ^(.+)@(.+)$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher((CharSequence) mailId);
		return matcher.matches();
	}

	public String[] validateInvoiceNumber(final String invoiceNumber) throws Exception {

		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside validateInvoiceNumber method:" + invoiceNumber);
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String[] str = new String[2];
		try {
			connectionObject = util.getDataSource().getConnection();
			preparedStatement = connectionObject.prepareStatement(SQLStatements.QUERY_FIND_INVOICE);
			traceLog.traceFinest("QUERY_FIND_INVOICE: " + SQLStatements.QUERY_FIND_INVOICE);
			preparedStatement.setString(1, invoiceNumber);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				str[0] = resultSet.getString(1);
				str[1] = resultSet.getString(2);
			}

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside validateInvoiceNumber:: " + e.getMessage());
		} finally {
			util.closeResources(resultSet, connectionObject, preparedStatement, null);
		}
		traceLog.traceFinest("Invoice count:: " + str);
		return str;
	}

	/**
	 * 
	 * @param String_Value
	 * @return String
	 * @throws Exception
	 * @Owner Pankaj K
	 */

	public String executeQueryForPath(final String columnName) throws Exception {
		String sftpPath = null;
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside executeQueryForPath method:" + columnName);
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connectionObject = util.getDataSource().getConnection();
			preparedStatement = connectionObject.prepareStatement(SQLStatements.QUERY_GPARAMS);
			traceLog.traceFinest("GPAEAM_SQL: " + SQLStatements.QUERY_GPARAMS);
			preparedStatement.setString(1, columnName);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				sftpPath = resultSet.getString(1);
			}

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside executeQueryForPath:: " + e.getMessage());
		} finally {
			util.closeResources(resultSet, connectionObject, preparedStatement, null);
		}
		return sftpPath;
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

}
