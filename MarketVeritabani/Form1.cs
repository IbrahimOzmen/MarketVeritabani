using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MarketVeritabani
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        NpgsqlConnection conn = new NpgsqlConnection("server=localHost; port=5432; Database=MarketVeritabani; user ID=postgres; password=ibrahim");
        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }
        
        private void btnlistele_Click(object sender, EventArgs e)
        {
            string sorgu = "select * from urun";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
        }

        private void btnekle_Click(object sender, EventArgs e)
        {
            conn.Open();
            NpgsqlCommand komut1 = new NpgsqlCommand("insert into urun (urunid, adi, uretimyeri, alisfiyat, satisfiyat, stokadedi, kargoid, tedarikciid, reyonid) values (@p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9)", conn);
            komut1.Parameters.AddWithValue("@p1", int.Parse(txturunid.Text));
            komut1.Parameters.AddWithValue("@p2", txtadi.Text);
            komut1.Parameters.AddWithValue("@p3", txturetim.Text);
            komut1.Parameters.AddWithValue("@p4", int.Parse(txtalis.Text));
            komut1.Parameters.AddWithValue("@p5", int.Parse(txtsatis.Text));
            komut1.Parameters.AddWithValue("@p6", int.Parse(txtstok.Text));
            komut1.Parameters.AddWithValue("@p7", int.Parse(txtkargo.Text));
            komut1.Parameters.AddWithValue("@p8", int.Parse(txttedarik.Text));
            komut1.Parameters.AddWithValue("@p9", int.Parse(txtreyon.Text));
            komut1.ExecuteNonQuery();
            conn.Close();
            MessageBox.Show("Ürün ekleme işlemi gerçekleştirildi", "", MessageBoxButtons.OK, MessageBoxIcon.Information);



        }
        private void btnguncelle_Click(object sender, EventArgs e)
        {
            conn.Open();
            NpgsqlCommand komut2 = new NpgsqlCommand("update urun set adi=@p1, alisfiyat=@p2, satisfiyat=@p3 where urunid=@p4", conn);
            komut2.Parameters.AddWithValue("@p1", txtadi.Text);
            komut2.Parameters.AddWithValue("@p2", int.Parse(txtalis.Text));
            komut2.Parameters.AddWithValue("@p3", int.Parse(txtsatis.Text));
            komut2.Parameters.AddWithValue("@p4", int.Parse(txturunid.Text));
            komut2.ExecuteNonQuery();
            conn.Close();
            MessageBox.Show("Ürün güncelleme işlemi gerçekleştirildi", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void btnsil_Click(object sender, EventArgs e)
        {
            conn.Open();
            NpgsqlCommand komut2 = new NpgsqlCommand("delete from urun where urunid=@p1", conn);
            komut2.Parameters.AddWithValue("@p1", int.Parse(txturunid.Text));
            komut2.ExecuteNonQuery();
            conn.Close();
            MessageBox.Show("Ürün silme işlemi gerçekleştirildi","",MessageBoxButtons.OK,MessageBoxIcon.Information);
            
        }


    }
}
