package br.jus.tjrr.siga.assinador;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSeparator;
import javax.swing.SwingConstants;

public class DialogEscolhaCertificado extends JDialog implements ActionListener {

	// private final JPanel contentPanel = new JPanel();
	//private JComboBox<String> comboBox = null;
	private JButton btnOk = new JButton("OK");
	private JButton btnCancel = new JButton("Cancelar");	
	private String result;

	/**
	 * Create the dialog.
	 */
	public DialogEscolhaCertificado(ArrayList<Certificate> listaCertificados) {
		setTitle("Certificados");
		setModalityType(ModalityType.APPLICATION_MODAL);
		setBounds(100, 100, 500, 350);
		BorderLayout borderLayout = new BorderLayout();
		getContentPane().setLayout(borderLayout);

		// Label Panel
		JPanel labelPanel = new JPanel();
		labelPanel.setLayout(new BorderLayout(0, 0));
		labelPanel.setBorder(BorderFactory.createEmptyBorder(20, 5, 5, 5));
		labelPanel.setBackground(Color.WHITE);
		getContentPane().add(labelPanel, BorderLayout.NORTH);
		{
			JLabel lbEscolhaCertificado = new JLabel(
					"Selecione um certificado:");
			int fontSize = 20;
			lbEscolhaCertificado.setFont(new Font(lbEscolhaCertificado
					.getName(), Font.PLAIN, fontSize));

			lbEscolhaCertificado.setHorizontalAlignment(SwingConstants.LEFT);
			labelPanel.add(lbEscolhaCertificado, BorderLayout.NORTH);
		}
		{
			JSeparator separator = new JSeparator();
			labelPanel.add(separator, BorderLayout.SOUTH);
		}

		// Content Panel
		JPanel contentPanel = new JPanel();
		contentPanel.setBorder(BorderFactory.createEmptyBorder(10, 15, 10, 15));
		contentPanel.setLayout(new BoxLayout(contentPanel, BoxLayout.PAGE_AXIS));
		contentPanel.setBackground(Color.WHITE);
		
		JScrollPane scrollPane = new JScrollPane(contentPanel);
		scrollPane.setBorder(BorderFactory.createEmptyBorder(1, 1, 1, 1));
		scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
				
		getContentPane().add(scrollPane);
		{
			addCertificatesButtons(contentPanel, listaCertificados);
		}

		// Button Panel
		JPanel buttonPane = new JPanel();
		buttonPane.setLayout(new FlowLayout(FlowLayout.CENTER));
		getContentPane().add(buttonPane, BorderLayout.SOUTH);
		{
			btnOk = new JButton("OK");
			btnOk.setMinimumSize(new Dimension(96, 25));
			btnOk.setMaximumSize(new Dimension(96, 25));
			btnOk.setPreferredSize(new Dimension(96, 25));
			btnOk.setActionCommand("OK");
			btnOk.addActionListener(this);
			getRootPane().setDefaultButton(btnOk);
	        
			buttonPane.add(btnOk);
		}
		{
			btnCancel = new JButton("Cancelar");
			btnCancel.setActionCommand("Cancelar");
			btnCancel.addActionListener(this);
			buttonPane.add(btnCancel);
		}

		setResizable(false);
        setModal(true);
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setVisible(true);
	}

    public void addCertificatesButtons(JPanel panel, ArrayList<Certificate> listaCertificados) {
				
		for (int i = 0; i < listaCertificados.size(); ++i) {
			Certificate cert = listaCertificados.get(i);
			String emissor = cert.getIssuer().getCommonName();
			String requerente = cert.getSubject().getCommonName();

			SimpleDateFormat formatoData = new SimpleDateFormat("dd/MM/yyyy");
			String validade = "Válido de " + cert.getNotBefore(formatoData)
					+ " até " + cert.getNotAfter(formatoData);

			String certDescription = "<html>"
					+ "<p style=\"font-family: Verdana; font-size:14px;\">"
					+ requerente
					+ "</p>"
					+ "<p style=\"font-family: Verdana; font-size:9px;\"><b>Emissor:</b> "
					+ emissor
					+ "</p>"
					+ "<p style=\"font-family: Verdana; font-size:9px;\"><b>Validade:</b> "
					+ validade + "</p>" + "</html>";

			Path path = FileSystems.getDefault().getPath("icons",
					"smartcard64x64.png");
			ImageIcon certIcon = new ImageIcon(path.toString());

			JButton certButton = new JButton(certDescription, certIcon);
			certButton.setName(cert.getSubject().toString()+";"+cert.getIssuer().toString());
			certButton.setMaximumSize(new Dimension(450, 100));
			certButton.setSelected(false);
			certButton.addActionListener(this);
			
			panel.add(certButton);
			panel.add(Box.createRigidArea(new Dimension(0,5)));
		}
	}
    
	public void actionPerformed(ActionEvent e) {
		
		if (e.getSource() != btnOk && e.getSource() != btnCancel && e.getSource() instanceof JButton){

			JButton btn = (JButton) e.getSource();
			result = btn.getName();		
		
		} else if(e.getSource() == btnCancel){
			result = null;
			dispose();
		} else {
			dispose();
		}
			
	}

	public HashMap<String, String> getResult() {
		
		HashMap<String, String> certData = new HashMap<String, String>();
		
		String[] data = result.split(";");
		certData.put("subject", data[0]);
		certData.put("issuer", data[1]);		
		
		return certData;
	}
}
