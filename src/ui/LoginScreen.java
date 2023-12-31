package ui;

import database.DatabaseConnectionHandler;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class LoginScreen extends JFrame {
    // Components
    private JLabel titleLabel;
    private JLabel usernameLabel;
    private JLabel passwordLabel;
    private JTextField usernameField;
    private JPasswordField passwordField;
    private JButton loginButton;

    private DatabaseConnectionHandler dbHandler;

    public LoginScreen() {

        setTitle("Basketball Database Oracle Login");
        setSize(600, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(null);

        dbHandler = new DatabaseConnectionHandler();
        titleLabel = new JLabel("Oracle Database Login");
        titleLabel.setFont(new Font("Arial", Font.BOLD, 30));
        titleLabel.setHorizontalAlignment((int) JLabel.CENTER_ALIGNMENT);
        titleLabel.setBounds(90, 50, 400, 40);

        usernameLabel = new JLabel("Username:");
        usernameLabel.setFont(new Font("Arial", Font.BOLD, 17));
        usernameLabel.setBounds(120, 108, 200, 75);

        usernameField = new JTextField();
        usernameField.setText("ora_");
        usernameField.setBounds(220, 123, 300, 40);

        passwordLabel = new JLabel("Password:");
        passwordLabel.setFont(new Font("Arial", Font.BOLD, 17));
        passwordLabel.setBounds(120, 168, 200, 75);

        passwordField = new JPasswordField();
        passwordField.setBounds(220, 183, 300, 40);

        loginButton = new JButton("Login");
        loginButton.setFont(new Font("Arial", Font.BOLD, 17));
        loginButton.setBounds(250, 260, 100, 50);
        loginButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                String username = usernameField.getText();
                char[] passwordChars = passwordField.getPassword();
                String password = new String(passwordChars);

                if (dbHandler.login(username, password)) {
                    System.out.println("Login successful!");
                    JOptionPane.showMessageDialog(LoginScreen.this, "Login successful!");
                    dispose();
                    new MainMenu(dbHandler);
                } else {
                    System.out.println("Login failed. Please check your credentials.");
                    JOptionPane.showMessageDialog(LoginScreen.this, "Login failed. Please check your credentials.");
                    passwordField.setText("");
                }
            }
        });

        add(titleLabel);
        add(usernameLabel);
        add(usernameField);
        add(passwordLabel);
        add(passwordField);
        add(loginButton);
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        setLocation((screenSize.width - getWidth()) / 2, (screenSize.height - getHeight()) / 2);
        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

    }

}
