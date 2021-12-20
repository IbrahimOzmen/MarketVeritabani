
namespace MarketVeritabani
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.txturunid = new System.Windows.Forms.TextBox();
            this.btnlistele = new System.Windows.Forms.Button();
            this.txtadi = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txturetim = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.txttedarik = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.txtkargo = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.txtreyon = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.txtsatis = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtalis = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtstok = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.btnekle = new System.Windows.Forms.Button();
            this.btnguncelle = new System.Windows.Forms.Button();
            this.btnsil = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(355, 7);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 51;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(812, 472);
            this.dataGridView1.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(49, 12);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(92, 25);
            this.label1.TabIndex = 1;
            this.label1.Text = "Ürün ID:";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // txturunid
            // 
            this.txturunid.Location = new System.Drawing.Point(147, 9);
            this.txturunid.Name = "txturunid";
            this.txturunid.Size = new System.Drawing.Size(185, 30);
            this.txturunid.TabIndex = 2;
            // 
            // btnlistele
            // 
            this.btnlistele.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(31)))), ((int)(((byte)(177)))), ((int)(((byte)(140)))));
            this.btnlistele.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnlistele.Location = new System.Drawing.Point(147, 333);
            this.btnlistele.Name = "btnlistele";
            this.btnlistele.Size = new System.Drawing.Size(185, 32);
            this.btnlistele.TabIndex = 3;
            this.btnlistele.Text = "LİSTELE";
            this.btnlistele.UseVisualStyleBackColor = false;
            this.btnlistele.Click += new System.EventHandler(this.btnlistele_Click);
            // 
            // txtadi
            // 
            this.txtadi.Location = new System.Drawing.Point(147, 45);
            this.txtadi.Name = "txtadi";
            this.txtadi.Size = new System.Drawing.Size(185, 30);
            this.txtadi.TabIndex = 5;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(90, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(51, 25);
            this.label2.TabIndex = 4;
            this.label2.Text = "Adı:";
            // 
            // txturetim
            // 
            this.txturetim.Location = new System.Drawing.Point(147, 81);
            this.txturetim.Name = "txturetim";
            this.txturetim.Size = new System.Drawing.Size(185, 30);
            this.txturetim.TabIndex = 11;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(16, 84);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(125, 25);
            this.label6.TabIndex = 10;
            this.label6.Text = "Üretim Yeri:";
            this.label6.Click += new System.EventHandler(this.label6_Click);
            // 
            // txttedarik
            // 
            this.txttedarik.Location = new System.Drawing.Point(147, 261);
            this.txttedarik.Name = "txttedarik";
            this.txttedarik.Size = new System.Drawing.Size(185, 30);
            this.txttedarik.TabIndex = 17;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(6, 264);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(135, 25);
            this.label7.TabIndex = 16;
            this.label7.Text = "Tedarikçi ID:";
            // 
            // txtkargo
            // 
            this.txtkargo.Location = new System.Drawing.Point(147, 225);
            this.txtkargo.Name = "txtkargo";
            this.txtkargo.Size = new System.Drawing.Size(185, 30);
            this.txtkargo.TabIndex = 15;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(37, 228);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(104, 25);
            this.label8.TabIndex = 14;
            this.label8.Text = "Kargo ID:";
            // 
            // txtreyon
            // 
            this.txtreyon.Location = new System.Drawing.Point(147, 297);
            this.txtreyon.Name = "txtreyon";
            this.txtreyon.Size = new System.Drawing.Size(185, 30);
            this.txtreyon.TabIndex = 19;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(34, 300);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(107, 25);
            this.label9.TabIndex = 18;
            this.label9.Text = "Reyon ID:";
            // 
            // txtsatis
            // 
            this.txtsatis.Location = new System.Drawing.Point(147, 153);
            this.txtsatis.Name = "txtsatis";
            this.txtsatis.Size = new System.Drawing.Size(185, 30);
            this.txtsatis.TabIndex = 23;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(16, 156);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(126, 25);
            this.label3.TabIndex = 22;
            this.label3.Text = "Satış Fiyatı:";
            this.label3.Click += new System.EventHandler(this.label3_Click);
            // 
            // txtalis
            // 
            this.txtalis.Location = new System.Drawing.Point(147, 117);
            this.txtalis.Name = "txtalis";
            this.txtalis.Size = new System.Drawing.Size(185, 30);
            this.txtalis.TabIndex = 21;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(28, 120);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(113, 25);
            this.label4.TabIndex = 20;
            this.label4.Text = "Alış Fiyatı:";
            // 
            // txtstok
            // 
            this.txtstok.Location = new System.Drawing.Point(147, 189);
            this.txtstok.Name = "txtstok";
            this.txtstok.Size = new System.Drawing.Size(185, 30);
            this.txtstok.TabIndex = 25;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(16, 192);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(125, 25);
            this.label5.TabIndex = 24;
            this.label5.Text = "Stok Adedi:";
            this.label5.Click += new System.EventHandler(this.label5_Click);
            // 
            // btnekle
            // 
            this.btnekle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(31)))), ((int)(((byte)(177)))), ((int)(((byte)(140)))));
            this.btnekle.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnekle.Location = new System.Drawing.Point(147, 371);
            this.btnekle.Name = "btnekle";
            this.btnekle.Size = new System.Drawing.Size(185, 32);
            this.btnekle.TabIndex = 26;
            this.btnekle.Text = "EKLE";
            this.btnekle.UseVisualStyleBackColor = false;
            this.btnekle.Click += new System.EventHandler(this.btnekle_Click);
            // 
            // btnguncelle
            // 
            this.btnguncelle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(31)))), ((int)(((byte)(177)))), ((int)(((byte)(140)))));
            this.btnguncelle.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnguncelle.Location = new System.Drawing.Point(147, 409);
            this.btnguncelle.Name = "btnguncelle";
            this.btnguncelle.Size = new System.Drawing.Size(185, 32);
            this.btnguncelle.TabIndex = 27;
            this.btnguncelle.Text = "GÜNCELLE";
            this.btnguncelle.UseVisualStyleBackColor = false;
            this.btnguncelle.Click += new System.EventHandler(this.btnguncelle_Click);
            // 
            // btnsil
            // 
            this.btnsil.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(31)))), ((int)(((byte)(177)))), ((int)(((byte)(140)))));
            this.btnsil.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnsil.Location = new System.Drawing.Point(147, 447);
            this.btnsil.Name = "btnsil";
            this.btnsil.Size = new System.Drawing.Size(185, 32);
            this.btnsil.TabIndex = 28;
            this.btnsil.Text = "SİL";
            this.btnsil.UseVisualStyleBackColor = false;
            this.btnsil.Click += new System.EventHandler(this.btnsil_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(13F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.ClientSize = new System.Drawing.Size(1176, 486);
            this.Controls.Add(this.btnsil);
            this.Controls.Add(this.btnguncelle);
            this.Controls.Add(this.btnekle);
            this.Controls.Add(this.txtstok);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.txtsatis);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.txtalis);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtreyon);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.txttedarik);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.txtkargo);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.txturetim);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.txtadi);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.btnlistele);
            this.Controls.Add(this.txturunid);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dataGridView1);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.Margin = new System.Windows.Forms.Padding(5);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txturunid;
        private System.Windows.Forms.Button btnlistele;
        private System.Windows.Forms.TextBox txtadi;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txturetim;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txttedarik;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtkargo;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox txtreyon;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox txtsatis;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtalis;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtstok;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button btnekle;
        private System.Windows.Forms.Button btnguncelle;
        private System.Windows.Forms.Button btnsil;
    }
}

